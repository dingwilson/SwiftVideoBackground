//
//  BackgroundVideo.swft
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 9/20/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import AVFoundation
import UIKit

/// Class that plays a video on a UIView.
public class BackgroundVideo {
    private var player = AVPlayer()

    /// Plays a video on a given UIView.
    ///
    /// - Parameters:
    ///     - view: UIView that the video will be played on.
    ///     - videoName: String name of video that you have added to your project.
    ///     - videoType: String type of the video. e.g. "mp4"
    ///     - isMuted: Bool indicating whether video is muted. Defaults to true.
    ///     - opacity: The opacity of the layer, as a value between zero and one.
    ///                Defaults to one. Specifying a value outside the [0,1]
    ///                range will give undefined results.
    ///     - loopVideo: Bool indicating whether video should restart when finished.
    ///                  Defaults to true.
    public func play(view: UIView,
                     videoName: String,
                     videoType: String,
                     isMuted: Bool = true,
                     opacity: Float = 1.0,
                     loopVideo: Bool = true) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            print("BackgroundVideo: [ERROR] could not find video")
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        player.isMuted = isMuted
        player.play()

        let layer = AVPlayerLayer(player: player)
        layer.frame = view.frame
        layer.opacity = opacity
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.zPosition = -1
        view.layer.addSublayer(layer)

        if loopVideo {
            addVideoDidPlayToEndObserver()
        } else {
            // this triggers a Lint error, but i think it's needed because e.g. this scenario:
            // user calls play(loopVideo = true), then
            // user calls play(loopVideo = false)
            // at this point we need to remove the observer or else the video will still loop
            removeAllObservers()
        }
    }

    private func addVideoDidPlayToEndObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(restartVideo),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }

    private func removeAllObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private dynamic func restartVideo() {
        player.seek(to: kCMTimeZero)
        player.play()
    }

    deinit {
        removeAllObservers()
    }
}

