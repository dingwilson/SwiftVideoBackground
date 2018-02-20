//
//  ExampleViewController.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 2/20/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
// import SwiftVideoBackground

class ExampleViewController: UIViewController {

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try VideoBackground.shared.play(view: self.view, name: "Background", type: "mp4")
        } catch {
            print(error.localizedDescription)
        }
    }

}
