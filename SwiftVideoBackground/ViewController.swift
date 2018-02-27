import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        try? VideoBackground.shared.play(view: view, videoName: "Background", videoType: "mp4")

        navigationController?.isNavigationBarHidden = true
    }
}
