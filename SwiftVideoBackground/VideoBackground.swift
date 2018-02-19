//
//  VideoBackground.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 9/20/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import AVFoundation
import UIKit

public struct VideoInfo {
    public let name: String
    public let type: String
}

public enum VideoBackgroundError: Error {
    case videoNotFound(VideoInfo)
}

/// Class that plays a video on a UIView.
public class VideoBackground {
    public static let shared = VideoBackground()

    private lazy var player = AVQueuePlayer()

    private lazy var layer = AVPlayerLayer()

    private lazy var overlayView = UIView()

    private lazy var playerItems = [AVPlayerItem]()

    private lazy var willLoopVideo = true

    private lazy var playerItemDidPlayToEndObservers = [NSObjectProtocol]()

    private var viewBoundsObserver: NSKeyValueObservation?

    private var applicationWillEnterForegroundObserver: NSObjectProtocol?

    private var playerItemDidPlayToEndObserver: NSObjectProtocol?

    /// Initializes a VideoBackground instance.
    public init() {
        // Resume video when application re-enters foreground
        applicationWillEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.player.play()
        }

        // Restart a single video when it ends
        setPlayerItemDidPlayToEndObserver()
    }

    private func setPlayerItemDidPlayToEndObserver() {
        playerItemDidPlayToEndObserver = NotificationCenter.default.addObserver(
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
    ///     - aplha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    @available(*, deprecated, message: "Please use the new throwing APIs.")
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) {
        do {
            try play(
                view: view,
                videos: [VideoInfo(name: videoName, type: videoType)],
                isMuted: isMuted,
                alpha: alpha,
                willLoopVideo: willLoopVideo
            )
        } catch {
            print("Could not find \(videoName).\(videoType).")
        }
    }

    public func play(view: UIView,
                     name: String,
                     type: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) throws {
        try play(
            view: view,
            videos: [VideoInfo(name: name, type: type)],
            isMuted: isMuted,
            alpha: alpha,
            willLoopVideo: willLoopVideo
        )
    }

    public func play(view: UIView,
                     videos: [VideoInfo],
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) throws {
        cleanUp()

        guard !videos.isEmpty else {
            return
        }

        playerItems = try makeAVPlayerItems(videos)

        if playerItems.count > 1 {
            if willLoopVideo {
                playerItems.forEach { [weak self] in
                    let observer = NotificationCenter.default.addObserver(
                        forName: .AVPlayerItemDidPlayToEndTime,
                        object: $0,
                        queue: .main) { notification in
                            if let currentItem = notification.object as? AVPlayerItem {
                                currentItem.seek(to: kCMTimeZero, completionHandler: nil)
                                self?.player.advanceToNextItem()
                                self?.player.insert(currentItem, after: nil)
                            }
                    }
                    self?.playerItemDidPlayToEndObservers.append(observer)
                }
            }
        } else {
            self.willLoopVideo = willLoopVideo
            setPlayerItemDidPlayToEndObserver()
        }

        player = AVQueuePlayer(items: playerItems)
        player.actionAtItemEnd = playerItems.count == 1 ? .none : .advance
        player.isMuted = isMuted
        player.play()

        layer = AVPlayerLayer(player: player)
        layer.frame = view.frame
        layer.videoGravity = .resizeAspectFill
        layer.zPosition = -1
        view.layer.insertSublayer(layer, at: 0)

        if alpha > 0 && alpha <= 1 {
            overlayView = UIView(frame: view.frame)
            overlayView.alpha = alpha
            overlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            overlayView.backgroundColor = .black
            view.addSubview(overlayView)
            view.sendSubview(toBack: overlayView)
        }

        // Adjust frames upon device rotation
        viewBoundsObserver = view.layer.observe(\.bounds) { [weak self] view, _ in
            DispatchQueue.main.async {
                self?.layer.frame = view.frame
            }
        }
    }

    private func cleanUp() {
        overlayView.removeFromSuperview()

        player.removeAllItems()

        removePlayerItemDidPlayToEndObservers()

        playerItemDidPlayToEndObservers.removeAll()
    }

    private func removePlayerItemDidPlayToEndObservers() {
        playerItemDidPlayToEndObservers.forEach {
            NotificationCenter.default.removeObserver($0)
        }
    }

    private func makeAVPlayerItems(_ videos: [VideoInfo]) throws -> [AVPlayerItem] {
        return try videos.map {
            return try makeAVPlayerItem($0)
        }
    }

    private func makeAVPlayerItem(_ videoInfo: VideoInfo) throws -> AVPlayerItem {
        guard let path = Bundle.main.path(forResource: videoInfo.name, ofType: videoInfo.type) else {
            throw VideoBackgroundError.videoNotFound(videoInfo)
        }
        let url = URL(fileURLWithPath: path)
        return AVPlayerItem(url: url)
    }

    deinit {
        if let applicationWillEnterForegroundObserver = applicationWillEnterForegroundObserver {
            NotificationCenter.default.removeObserver(applicationWillEnterForegroundObserver)
        }
        if let playerItemDidPlayToEndObserver = playerItemDidPlayToEndObserver {
            NotificationCenter.default.removeObserver(playerItemDidPlayToEndObserver)
        }
        removePlayerItemDidPlayToEndObservers()
        viewBoundsObserver?.invalidate()
    }
}
