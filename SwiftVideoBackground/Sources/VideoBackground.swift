//
//  VideoBackground.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 9/20/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import AVFoundation
import UIKit

/// Class that plays and manages control of a video on a `UIView`.
public class VideoBackground {
    /// Singleton that can play one video on one `UIView` at a time.
    public static let shared = VideoBackground()

    /// Change this `CGFloat` to adjust the darkness of the video. Value `0` to `1`. Higher numbers are darker. Setting
    /// to an invalid value does nothing.
    public var darkness: CGFloat = 0 {
        didSet {
            if darkness > 0 && darkness <= 1 {
                darknessOverlayView.alpha = darkness
            }
        }
    }

    /// Change this `Bool` to mute/unmute the video.
    public var isMuted = true {
        didSet {
            playerLayer.player?.isMuted = isMuted
        }
    }

    /// Change this `Bool` to set whether the video restarts when it ends.
    public var willLoopVideo = true

    /// Default is `.resizeAspectFill`. Change to `.resizeAspect` (doesn't fill view)
    /// or `.resize` (doesn't conserve aspect ratio)
    public var videoGravity: AVLayerVideoGravity = .resizeAspectFill

    /// The `AVPlayerLayer` that can be accessed for advanced customization.
    public lazy var playerLayer = AVPlayerLayer(player: player)

    private var player = AVPlayer(playerItem: nil)

    private var cache = [URL: AVPlayerItem]()

    private lazy var darknessOverlayView = UIView()

    private var applicationWillEnterForegroundObserver: NSObjectProtocol?

    private var playerItemDidPlayToEndObserver: NSObjectProtocol?

    private var viewBoundsObserver: NSKeyValueObservation?

    /// You only need to initialize your own instance of `VideoBackground` if you are playing multiple videos on
    /// multiple `UIViews`. Otherwise just use the `shared` singleton.
    public init() {
        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.playerLayer.player?.play()
        }
    }

    /// Plays a local video.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - darkness: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    ///     - setAudioSessionAmbient: Bool indicating whether to set the shared `AVAudioSession` to ambient. If this is
    ///         not done, audio played from your app will pause other audio playing on the device. Defaults to true.
    ///         Only has an effect in iOS 10.0+.
    /// - Throws: `VideoBackgroundError.videoNotFound` if the video cannot be found.
    ///     - preventsDisplaySleepDuringVideoPlayback: If automatic lock is being used on the device
    ///         setting this property to false will not hold the device awake.
    ///         default value for iOS is true.
    ///         Only has an effect in iOS 12.0+
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     darkness: CGFloat = 0,
                     willLoopVideo: Bool = true,
                     setAudioSessionAmbient: Bool = true,
                     preventsDisplaySleepDuringVideoPlayback: Bool = true) throws {
        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            throw VideoBackgroundError.videoNotFound((name: videoName, type: videoType))
        }
        let url = URL(fileURLWithPath: path)
        play(
            view: view,
            url: url,
            darkness: darkness,
            isMuted: isMuted,
            willLoopVideo: willLoopVideo,
            setAudioSessionAmbient: setAudioSessionAmbient,
            preventsDisplaySleepDuringVideoPlayback: preventsDisplaySleepDuringVideoPlayback
        )
    }

    /// Plays a video from a local or remote URL.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - url: URL of the video. Can be from your local file system or the web. Invalid URLs will not be played but
    ///         do not return any error.
    ///     - darkness: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    ///     - setAudioSessionAmbient: Bool indicating whether to set the shared `AVAudioSession` to ambient. If this is
    ///         not done, audio played from your app will pause other audio playing on the device. Defaults to true.
    ///         Only has an effect in iOS 10.0+.
    ///     - preventsDisplaySleepDuringVideoPlayback: If automatic lock is being used on the device
    ///         setting this property to false will not hold the device awake.
    ///         default value for iOS is true.
    ///         Only has an effect in iOS 12.0+
    public func play(view: UIView,
                     url: URL,
                     darkness: CGFloat = 0,
                     isMuted: Bool = true,
                     willLoopVideo: Bool = true,
                     setAudioSessionAmbient: Bool = true,
                     preventsDisplaySleepDuringVideoPlayback: Bool = true) {
        cleanUp()

        if setAudioSessionAmbient {
            if #available(iOS 10.0, *) {
                try? AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.ambient,
                    mode: AVAudioSession.Mode.default
                )
                try? AVAudioSession.sharedInstance().setActive(true)
            }
        }
        if #available(iOS 12.0, *) {
            player.preventsDisplaySleepDuringVideoPlayback = preventsDisplaySleepDuringVideoPlayback
        }

        self.willLoopVideo = willLoopVideo

        if cache[url] == nil {
            cache[url] = AVPlayerItem(url: url)
        }

        player.replaceCurrentItem(with: cache[url])
        player.actionAtItemEnd = .none
        player.isMuted = isMuted
        player.play()

        playerLayer.frame = view.bounds
        playerLayer.needsDisplayOnBoundsChange = true
        playerLayer.videoGravity = videoGravity
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)

        darknessOverlayView = UIView(frame: view.bounds)
        darknessOverlayView.alpha = 0
        darknessOverlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        darknessOverlayView.backgroundColor = .black
        self.darkness = darkness
        view.addSubview(darknessOverlayView)
        view.sendSubviewToBack(darknessOverlayView)

        // Restart video when it ends
        playerItemDidPlayToEndObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak self] _ in
                if let willLoopVideo = self?.willLoopVideo, willLoopVideo {
                    self?.restart()
                }
        }

        // Adjust frames upon device rotation
        viewBoundsObserver = view.layer.observe(\.bounds) { [weak self] view, _ in
            DispatchQueue.main.async {
                self?.playerLayer.frame = view.bounds
            }
        }
    }

    /// Pauses the video.
    public func pause() {
        playerLayer.player?.pause()
    }

    /// Resumes the video.
    public func resume() {
        playerLayer.player?.play()
    }

    /// Restarts the video from the beginning.
    public func restart() {
        playerLayer.player?.seek(to: CMTime.zero)
        playerLayer.player?.play()
    }

    /// Generate an image from the video to show as thumbnail
    ///
    /// - Parameters:
    ///   - url: video file URL
    ///   - time: time of video frame to make into thumbnail image
    public func getThumbnailImage(from url: URL, at time: CMTime) throws -> UIImage {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let thumbnailImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: thumbnailImage)
    }

    private func cleanUp() {
        playerLayer.player?.pause()
        playerLayer.removeFromSuperlayer()
        darknessOverlayView.removeFromSuperview()
        if let playerItemDidPlayToEndObserver = playerItemDidPlayToEndObserver {
            NotificationCenter.default.removeObserver(playerItemDidPlayToEndObserver)
        }
        viewBoundsObserver?.invalidate()
    }

    deinit {
        cleanUp()
        if let applicationWillEnterForegroundObserver = applicationWillEnterForegroundObserver {
            NotificationCenter.default.removeObserver(applicationWillEnterForegroundObserver)
        }
    }
}
