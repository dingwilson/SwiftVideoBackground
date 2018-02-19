public enum VideoBackgroundError: LocalizedError {
    case videoNotFound(VideoInfo)

    public var errorDescription: String? {
        switch self {
        case . videoNotFound(let videoInfo): return "Could not find \(videoInfo.name).\(videoInfo.type)."
        }
    }
}
