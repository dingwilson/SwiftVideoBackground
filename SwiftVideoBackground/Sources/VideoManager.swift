import AVKit
import UIKit

class VideoManager {
    private let playerLayer: AVPlayerLayer

    private let alphaOverlayView: UIView

    private var willLoopVideo: Bool

    private var applicationWillEnterForegroundObserver: NSObjectProtocol?

    private var playerItemDidPlayToEndObserver: NSObjectProtocol?

    private var viewBoundsObserver: NSKeyValueObservation?

    init(view: UIView,
         url: URL,
         alpha: CGFloat,
         isMuted: Bool,
         willLoopVideo: Bool) {
        self.willLoopVideo = willLoopVideo

        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = isMuted
        player.play()

        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)

        alphaOverlayView = UIView(frame: view.bounds)
        alphaOverlayView.alpha = 0
        alphaOverlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alphaOverlayView.backgroundColor = .black
        setAlpha(alpha)
        view.addSubview(alphaOverlayView)
        view.sendSubview(toBack: alphaOverlayView)

        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.playerLayer.player?.play()
        }

        // Restart video when it ends
        playerItemDidPlayToEndObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak self] _ in
                if let willLoopVideo = self?.willLoopVideo, willLoopVideo {
                    self?.playerLayer.player?.seek(to: kCMTimeZero)
                    self?.playerLayer.player?.play()
                }
        }

        // Adjust frames upon device rotation
        viewBoundsObserver = view.layer.observe(\.bounds) { [weak self] view, _ in
            DispatchQueue.main.async {
                self?.playerLayer.frame = view.frame
            }
        }
    }

    func pause() {
        playerLayer.player?.pause()
    }

    func resume() {
        playerLayer.player?.play()
    }

    func setAlpha(_ alpha: CGFloat) {
        if alpha > 0 && alpha <= 1 {
            alphaOverlayView.alpha = alpha
        }
    }

    func setIsMuted(_ isMuted: Bool) {
        playerLayer.player?.isMuted = isMuted
    }

    func setWillLoopVideo(_ willLoopVideo: Bool) {
        self.willLoopVideo = willLoopVideo
    }

    func cleanUp() {
        playerLayer.player = nil
        playerLayer.removeFromSuperlayer()
        alphaOverlayView.removeFromSuperview()
        if let applicationWillEnterForegroundObserver = applicationWillEnterForegroundObserver {
            NotificationCenter.default.removeObserver(applicationWillEnterForegroundObserver)
        }
        if let playerItemDidPlayToEndObserver = playerItemDidPlayToEndObserver {
            NotificationCenter.default.removeObserver(playerItemDidPlayToEndObserver)
        }
        viewBoundsObserver?.invalidate()
    }

    deinit {
        print("🐸")
        cleanUp()
    }
}
