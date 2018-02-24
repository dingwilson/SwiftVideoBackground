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
    func testDidCreateVideoInfo() {
        let videoInfo = VideoInfo(name: "Background", type: "mp4")

        XCTAssertEqual(videoInfo.name, "Background")
        XCTAssertEqual(videoInfo.type, "mp4")
    }

    func testDidSuccessfullyCreateBackgroundVideo() {
        let view = UIView()

        do {
            try VideoBackground.shared.play(
                view: view,
                name: "Background",
                type: "mp4",
                isMuted: true,
                alpha: 0.2,
                willLoopVideo: true
            )
        } catch {
            XCTAssertNil(error)
        }
    }

    func testDidCatchNonexistantVideo() {
        let view = UIView()
        let videoInfo = VideoInfo(name: "NonExistantVideo", type: "mp4")

        do {
            try VideoBackground.shared.play(view: view, name: videoInfo.name, type: videoInfo.type)
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                VideoBackgroundError.videoNotFound(videoInfo).localizedDescription
            )
        }

        XCTAssert(view.subviews.isEmpty)
    }
}
