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
    /// DEPRECATED: Accessing VideoBackground is no longer needed. Play your video directly from your view with
    /// 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'.
    ///
    /// Singleton instance that can be used to play a video.
    @available(*, deprecated, message: "Use 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'")
    public static let shared = VideoBackground()

    /// DEPRECATED: Accessing VideoBackground is no longer needed. Play your video directly from your view with
    /// 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'.
    ///
    /// Initializes a VideoBackground instance.
    @available(*, deprecated, message: "Use 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'")
    public init() {}

    /// DEPRECATED: Accessing VideoBackground is no longer needed. Play your video directly from your view with
    /// 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'.
    ///
    /// Plays a video on a UIView.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - alpha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    @available(*, deprecated, message: "Use 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'")
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) {
        do {
            try view.playVideo(
                videoName: videoName,
                videoType: videoType,
                alpha: alpha,
                isMuted: isMuted,
                willLoopVideo: willLoopVideo
            )
        } catch {
            print(error.localizedDescription)
        }
    }

    /// DEPRECATED: Accessing VideoBackground is no longer needed. Play your video directly from your view with
    /// 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'.
    ///
    /// Plays a video on a UIView.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - name: String name of video that you have added to your project.
    ///     - type: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - alpha: CGFloat between 0 and 1. The higher the value, the darker the video. Defaults to 0.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to true.
    /// - Throws: `VideoBackgroundError.videoNotFound` if the video cannot be found.
    @available(*, deprecated, message: "Use 'yourView.playVideo(videoName:videoType:alpha:isMuted:willLoopVideo:)'")
    public func play(view: UIView,
                     name: String,
                     type: String,
                     isMuted: Bool = true,
                     alpha: CGFloat = 0,
                     willLoopVideo: Bool = true) throws {
        try view.playVideo(
            videoName: name,
            videoType: type,
            alpha: alpha,
            isMuted: isMuted,
            willLoopVideo: willLoopVideo
        )
    }
}
