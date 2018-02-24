import UIKit

class MoreViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!

    let videoBackground1 = VideoBackground()
    let videoBackground2 = VideoBackground()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    deinit {
        print("🦁")
    }

    // Video 1 - loads from web so takes a moment to start
    @IBAction func play1(_ sender: Any) {
        let url = URL(string: "https://storage.googleapis.com/coverr-main/mp4/Mt_Baker.mp4")!
        videoBackground1.play(view: view1, url: url, alpha: 0.1)
    }

    @IBAction func increaseAlpha(_ sender: Any) {
        videoBackground1.alpha += 0.1
    }

    @IBAction func decreaseAlpha(_ sender: Any) {
        videoBackground1.alpha -= 0.1
    }

    @IBAction func toggleRestart(_ sender: Any) {
        videoBackground1.willLoopVideo = !videoBackground1.willLoopVideo
    }

    // Video 2
    @IBAction func play2(_ sender: Any) {
        try? videoBackground2.play(view: view2, name: "pokemon", type: "mp4", isMuted: false)
    }

    @IBAction func pause(_ sender: Any) {
        videoBackground2.pause()
    }

    @IBAction func resume(_ sender: Any) {
        videoBackground2.resume()
    }

    @IBAction func restart(_ sender: Any) {
        videoBackground2.restart()
    }

    @IBAction func mute(_ sender: Any) {
        videoBackground2.isMuted = true
    }

    @IBAction func unmute(_ sender: Any) {
        videoBackground2.isMuted = false
    }
}
