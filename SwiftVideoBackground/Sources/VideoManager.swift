import AVKit
import UIKit

class VideoManager {
    private lazy var player = AVPlayer()

    private lazy var layer = AVPlayerLayer()

    private lazy var alphaOverlayView = UIView()

    private var willLoopVideo: Bool

    private var applicationWillEnterForegroundObserver: NSObjectProtocol?

    private var playerItemDidPlayToEndObserver: NSObjectProtocol?

    private var viewBoundsObserver: NSKeyValueObservation?

    init(view: UIView,
         videoName: String,
         videoType: String,
         alpha: CGFloat,
         isMuted: Bool,
         willLoopVideo: Bool) throws {
        self.willLoopVideo = willLoopVideo

        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            throw VideoBackgroundError.videoNotFound(VideoInfo(name: videoName, type: videoType))
        }

        let url = URL(fileURLWithPath: path)

        player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = isMuted
        player.play()

        layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        layer.zPosition = -1
        view.layer.insertSublayer(layer, at: 0)

        alphaOverlayView = UIView(frame: view.bounds)
        alphaOverlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alphaOverlayView.alpha = 0
        alphaOverlayView.backgroundColor = .black
        setAlpha(alpha)
        view.addSubview(alphaOverlayView)
        view.sendSubview(toBack: alphaOverlayView)

        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.player.play()
        }

        // Restart video when it ends
        playerItemDidPlayToEndObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak self] _ in
                if let willLoopVideo = self?.willLoopVideo, willLoopVideo {
                    self?.player.seek(to: kCMTimeZero)
                    self?.player.play()
                }
        }

        // Adjust frames upon device rotation
        viewBoundsObserver = view.layer.observe(\.bounds) { [weak self] view, _ in
            DispatchQueue.main.async {
                self?.layer.frame = view.frame
            }
        }
    }

    func pause() {
        player.pause()
    }

    func resume() {
        player.play()
    }

    func setAlpha(_ alpha: CGFloat) {
        if alpha > 0 && alpha <= 1 {
            alphaOverlayView.alpha = alpha
        }
    }

    func setPlayerIsMuted(_ isMuted: Bool) {
        player.isMuted = isMuted
    }

    func setPlayerWillLoopVideo(_ willLoopVideo: Bool) {
        self.willLoopVideo = willLoopVideo
    }

    deinit {
        layer.removeFromSuperlayer()
        alphaOverlayView.removeFromSuperview()
        if let applicationWillEnterForegroundObserver = applicationWillEnterForegroundObserver {
            NotificationCenter.default.removeObserver(applicationWillEnterForegroundObserver)
        }
        if let playerItemDidPlayToEndObserver = playerItemDidPlayToEndObserver {
            NotificationCenter.default.removeObserver(playerItemDidPlayToEndObserver)
        }
        viewBoundsObserver?.invalidate()
    }
}
