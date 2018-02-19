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

        XCTAssertThrowsError(try VideoBackground.shared.play(view: view, name: "NonExistantVideo", type: "mp4"))

        XCTAssert(view.subviews.isEmpty)
    }
}
