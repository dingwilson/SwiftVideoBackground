import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        try? VideoBackground.shared.play(view: view, name: "Background", type: "mp4")

        navigationController?.isNavigationBarHidden = true
    }
}
