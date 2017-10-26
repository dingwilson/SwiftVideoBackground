//
//  BackgroundVideoError.swift
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 10/26/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import Foundation

/**
 BackgroundVideoError
 - case: missingVideo - Invalid Video URL. Please check the video name and type.
 */
enum BackgroundVideoError: LocalizedError {
    case missingVideo    // missing video

    var errorDescription: String? {
        switch self {
        case .missingVideo: return "Invalid Video URL. Please check the video name and type."
        }
    }
}
