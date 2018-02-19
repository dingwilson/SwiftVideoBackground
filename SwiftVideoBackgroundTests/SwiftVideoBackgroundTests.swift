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
        let videoInfo = VideoInfo(name: "NonExistantVideo", type: "mp4")

        do {
            try VideoBackground.shared.play(view: view, videoInfos: [videoInfo])
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                VideoBackgroundError.videoNotFound(videoInfo).localizedDescription
            )
        }

        XCTAssert(view.subviews.isEmpty)
    }
}
