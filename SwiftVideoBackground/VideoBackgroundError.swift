/// Errors that can occur when playing a video.
public enum VideoBackgroundError: LocalizedError {
    /// The video with given name and type could not be found.
    case videoNotFound(VideoInfo)

    /// Description of the error.
    public var errorDescription: String? {
        switch self {
        case . videoNotFound(let videoInfo): return "Could not find \(videoInfo.name).\(videoInfo.type)."
        }
    }
}
