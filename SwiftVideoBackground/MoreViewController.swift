//
//  ExampleViewController.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 2/20/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!

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
        print(CFGetRetainCount(view1))
    }

    @IBAction func a(_ sender: Any) {
        print(CFGetRetainCount(view1))
//        let url = URL(
//            string: "https://ia800409.us.archive.org/16/items/PokemonOriginalIntro/Pokemon%20Original%20Intro.mp4"
//            )!
        let url = URL(string: "https://storage.googleapis.com/coverr-main/mp4/Mt_Baker.mp4")!
        view1.playVideo(url: url, isMuted: false)
        print(CFGetRetainCount(view1))
    }

    @IBAction func b(_ sender: Any) {
        try? view2.playVideo(videoName: "pokemon", videoType: "mp4", alpha: 0.2)
    }
}
