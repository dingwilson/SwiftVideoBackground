import UIKit

struct VideoManagers {
    static let shared = VideoManagers()

    let videoManagers = NSMapTable<UIView, VideoManager>(keyOptions: .weakMemory, valueOptions: .strongMemory)

    private init() {}
}
