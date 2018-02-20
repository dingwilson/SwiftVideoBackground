/// Contains data on a video to be played.
public struct VideoInfo {
    /// String name of the video.
    public let name: String

    /// String type of the video, e.g. "mp4"
    public let type: String

    /// Initializes a `VideoInfo`.
    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}
