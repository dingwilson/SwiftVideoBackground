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

    /// Change this `CGFloat` to adjust the darkness of the video. Value `0` to `1`. Higher numbers are darker. Invalid
    /// values are ignored.
    public var alpha: CGFloat = 0 {
        didSet {
            if alpha > 0 && alpha <= 1 {
                alphaOverlayView.alpha = alpha
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

    private lazy var playerLayer = AVPlayerLayer()

    private lazy var alphaOverlayView = UIView()

    private var applicationWillEnterForegroundObserver: NSObjectProtocol?

    private var playerItemDidPlayToEndObserver: NSObjectProtocol?

    private var viewBoundsObserver: NSKeyValueObservation?

    /// You only need to initialize your own instance of `VideoBackground` if you are playing multiple videos on
    /// multiple `UIViews`. Otherwise just use the `shared` singleton.
    public init() {
        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.playerLayer.player?.play()
        }
    }

    /// **DEPRECATED** Plays a video on a UIView.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - alpha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    ///     - setAudioSessionAmbient: Bool indicating whether to set the shared `AVAudioSession` to ambient. If this is
    ///         not done, audio played from your app will pause other audio playing on the device. Defaults to true.
    ///         Only has an effect in iOS 10.0+.
    @available(*, deprecated, message: "Please use the new throwing APIs.")
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true,
                     setAudioSessionAmbient: Bool = true) {
        do {
            try play(
                view: view,
                name: videoName,
                type: videoType,
                isMuted: isMuted,
                alpha: alpha,
                willLoopVideo: willLoopVideo,
                setAudioSessionAmbient: setAudioSessionAmbient
            )
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Plays a video.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - name: String name of video that you have added to your project.
    ///     - type: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - alpha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    ///     - setAudioSessionAmbient: Bool indicating whether to set the shared `AVAudioSession` to ambient. If this is
    ///         not done, audio played from your app will pause other audio playing on the device. Defaults to true.
    ///         Only has an effect in iOS 10.0+.
    /// - Throws: `VideoBackgroundError.videoNotFound` if the video cannot be found.
    public func play(view: UIView,
                     name: String,
                     type: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true,
                     setAudioSessionAmbient: Bool = true) throws {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw VideoBackgroundError.videoNotFound(VideoInfo(name: name, type: type))
        }
        let url = URL(fileURLWithPath: path)
        play(
            view: view,
            url: url,
            isMuted: isMuted,
            alpha: alpha,
            willLoopVideo: willLoopVideo,
            setAudioSessionAmbient: setAudioSessionAmbient
        )
    }

    /// Plays a video.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - url: URL of the video. Can be from your local file system or the web. Invalid URLs are ignored.
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - alpha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    ///     - setAudioSessionAmbient: Bool indicating whether to set the shared `AVAudioSession` to ambient. If this is
    ///         not done, audio played from your app will pause other audio playing on the device. Defaults to true.
    ///         Only has an effect in iOS 10.0+.
    public func play(view: UIView,
                     url: URL,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true,
                     setAudioSessionAmbient: Bool = true) {
        cleanUp()

        if setAudioSessionAmbient {
            if #available(iOS 10.0, *) {
                try? AVAudioSession.sharedInstance().setCategory(
                    AVAudioSessionCategoryAmbient,
                    mode: AVAudioSessionModeDefault
                )
                try? AVAudioSession.sharedInstance().setActive(true)
            }
        }

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
        self.alpha = alpha
        view.addSubview(alphaOverlayView)
        view.sendSubview(toBack: alphaOverlayView)

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
        playerLayer.player?.seek(to: kCMTimeZero)
        playerLayer.player?.play()
    }

    private func cleanUp() {
        playerLayer.player = nil
        alphaOverlayView.removeFromSuperview()
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
