//
//  SwiftVideoBackgroundTests.swift
//  SwiftVideoBackgroundTests
//
//  Created by Wilson Ding on 9/28/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import XCTest
import SwiftVideoBackground

class SwiftVideoBackgroundTests: XCTestCase {
    func testDidCatchNonexistantVideo() {
        let view = UIView()
        let videoBackground = VideoBackground()

        videoBackground.play(view: view, videoName: "NonexistantVideo", videoType: "mp4", alpha: 0.1)

        assert(view.subviews.isEmpty)
    }
}
