//
//  VideoBackground.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 9/20/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import AVFoundation
import UIKit

/// Class that plays a video on a UIView.
public class VideoBackground {
    private lazy var player = AVPlayer()

    private lazy var layer = AVPlayerLayer()

    private var applicationWillEnterForegroundObserver: NSObjectProtocol!

    private var videoEndedObserver: NSObjectProtocol!

    private var viewBoundsObserver: NSKeyValueObservation?

    private var willLoopVideo = true

    /// Initializes a VideoBackground instance.
    public init() {
        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.player.play()
        }

        // Restart video when it ends
        videoEndedObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak self] _ in
                if let willLoopVideo = self?.willLoopVideo, willLoopVideo {
                    self?.player.seek(to: kCMTimeZero)
                    self?.player.play()
                }
        }
    }

    /// Plays a video on a given UIView.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - aplha: CGFloat between 0 and 1. The higher the value, the darker
    ///              the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished.
    ///                      Defaults to true.
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            print("BackgroundVideo: [ERROR] could not find video")
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = isMuted
        player.play()

        layer = AVPlayerLayer(player: player)
        layer.frame = view.frame
        layer.videoGravity = .resizeAspectFill
        layer.zPosition = -1
        view.layer.insertSublayer(layer, at: 0)

        if alpha > 0 && alpha <= 1 {
            let overlayView = UIView(frame: view.frame)
            overlayView.backgroundColor = .black
            overlayView.alpha = alpha
            view.addSubview(overlayView)
            view.sendSubview(toBack: overlayView)
        }

        viewBoundsObserver = view.layer.observe(\.bounds) { [weak self] view, _ in
            DispatchQueue.main.async {
                self?.layer.frame = view.frame
            }
        }

        self.willLoopVideo = willLoopVideo
    }

    // Apparently in more recent iOS versions this is not needed
    deinit {
        NotificationCenter.default.removeObserver(applicationWillEnterForegroundObserver)
        NotificationCenter.default.removeObserver(videoEndedObserver)
        viewBoundsObserver?.invalidate()
    }
}
