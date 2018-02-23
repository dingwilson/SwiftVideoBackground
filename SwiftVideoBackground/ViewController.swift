import UIKit

class ViewController: UIViewController {
//    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        try? view.playVideo(videoName: "Background", videoType: "mp4")

        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(VideoManagers.shared.videoManagers.keyEnumerator().allObjects)
    }
}
