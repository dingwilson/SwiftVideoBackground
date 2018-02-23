import UIKit

public extension UIView {
    /// Plays a video on the UIView.
    ///
    /// - Parameters:
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - alpha: CGFloat between `0` and `1`. The higher the value, the darker the video. Defaults to `0`.
    ///     - isMuted: Bool indicating whether video is muted. Defaults to `true`.
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to `true`.
    /// - Throws: `VideoBackgroundError.videoNotFound` if the video cannot be found.
    public func playVideo(videoName: String,
                          videoType: String,
                          alpha: CGFloat = 0,
                          isMuted: Bool = true,
                          willLoopVideo: Bool = true) throws {
        let viewVideoManager =  try VideoManager(
            view: self,
            videoName: videoName,
            videoType: videoType,
            alpha: alpha,
            isMuted: isMuted,
            willLoopVideo: willLoopVideo
        )
        VideoManagers.shared.videoManagers.setObject(viewVideoManager, forKey: self)
    }

    /// Pauses the video playing on the `UIView`, if any.
    public func pauseVideo() {
        videoManager?.pause()
    }

    /// Resumes the video playing on the `UIView`, if any.
    public func resumeVideo() {
        videoManager?.resume()
    }

    /// Sets the darkness of the video playing on the `UIView`, if any.
    ///
    /// - Parameters:
    ///     - alpha: CGFloat between `0` and `1`. The higher the value, the darker the video. Defaults to `0`.
    public func setVideoAlpha(_ alpha: CGFloat) {
        videoManager?.setAlpha(alpha)
    }

    /// Mute/unmute the video playing on the `UIView`, if any.
    ///
    /// - Parameters:
    ///     - isMuted: Bool indicating whether video is muted. Defaults to `true`.
    public func setVideoIsMuted(_ isMuted: Bool) {
        videoManager?.setPlayerIsMuted(isMuted)
    }

    /// Set the video playing on the `UIView` to restart/don't restart when done.
    ///
    /// - Parameters:
    ///     - willLoopVideo: Bool indicating whether video should restart when finished. Defaults to `true`.
    public func setWillLoopVideo(_ willLoopVideo: Bool) {
        videoManager?.setPlayerWillLoopVideo(willLoopVideo)
    }

    private var videoManager: VideoManager? {
        return VideoManagers.shared.videoManagers.object(forKey: self)
    }
}
