//
//  SwiftVideoBackgroundTests.swift
//  SwiftVideoBackgroundTests
//
//  Created by Wilson Ding on 9/28/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import AVKit
import SwiftVideoBackground
import XCTest

class SwiftVideoBackgroundTests: XCTestCase {
    let videoName = "Background"
    let videoType = "mp4"
    var view = UIView()
    var player: AVPlayer? {
        return VideoBackground.shared.playerLayer.player
    }

    override func setUp() {
        super.setUp()
        view = UIView()
    }

    func testPlayLocalVideo() {
        do {
            try VideoBackground.shared.play(view: view, videoName: videoName, videoType: videoType)
        } catch {
            XCTAssertNil(error)
        }
    }

    func testPlayLocalVideoNotFound() {
        let videoInfo = (name: "NonExistantVideo", type: "mp4")

        do {
            try VideoBackground.shared.play(view: view, videoName: videoInfo.name, videoType: videoInfo.type)
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                VideoBackgroundError.videoNotFound(videoInfo).localizedDescription
            )
        }

        XCTAssert(view.subviews.isEmpty)
    }

    func testPlayFromURL() {
        let url = URL(string: "https://storage.googleapis.com/coverr-main/mp4/Mt_Baker.mp4")!
        VideoBackground.shared.play(view: view, url: url)
    }

    func testPause() {
        if #available(iOS 10.0, *) {
            play()
            VideoBackground.shared.pause()
            XCTAssertEqual(player?.timeControlStatus, AVPlayer.TimeControlStatus.paused)
        }
    }

    func testResume() {
        if #available(iOS 10.0, *) {
            play()
            VideoBackground.shared.pause()
            VideoBackground.shared.resume()
            XCTAssertEqual(player?.rate, 1)
        }
    }

    func testRestart() {
        if #available(iOS 10.0, *) {
            play()
            VideoBackground.shared.pause()
            VideoBackground.shared.restart()
            XCTAssertEqual(player?.rate, 1)
        }
    }

    func testSetIsMuted() {
        play()
        XCTAssertEqual(player?.isMuted, true)
        VideoBackground.shared.isMuted = false
        XCTAssertEqual(player?.isMuted, false)
    }
}

extension SwiftVideoBackgroundTests {
    func play() {
        try? VideoBackground.shared.play(view: view, videoName: videoName, videoType: videoType)
    }
}
