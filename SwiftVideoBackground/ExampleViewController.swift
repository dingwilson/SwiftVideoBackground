//
//  ExampleViewController.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 2/20/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        try? view.playVideo(videoName: "Background", videoType: "mp4", alpha: 0.9)
        try? view.playVideo(videoName: "Background", videoType: "mp4")

        do {
            try VideoBackground.shared.play(view: self.view, name: "Background", type: "mp4")
        } catch {
            print(error.localizedDescription)
        }
    }

    @IBAction func a(_ sender: Any) {
        try? view1.playVideo(videoName: "Background", videoType: "mp4", alpha: 0.3)
    }

    @IBAction func b(_ sender: Any) {
        try? view2.playVideo(videoName: "Background", videoType: "mp4", alpha: 0.6)
    }
}
