//
//  ViewController.swift
//  ExampleLogin
//
//  Created by Wilson Ding on 9/28/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class ViewController: UIViewController {

    @IBOutlet weak var backgroundVideo: BackgroundVideo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundVideo.createBackgroundVideo(name: "Background", type: "mp4", alpha: 0.5)
    }
}

