//
//  BackgroundVideo.swft
//  SwiftVideoBackground
//
//  Created by Wilson Ding on 9/20/16.
//  Copyright © 2016 Wilson Ding. All rights reserved.
//

import UIKit
import AVFoundation

public class BackgroundVideo: UIView {

    private var player: AVPlayer?
    
    /*
     createBackgroundVideo(name: String, type: String) function:
     - name: String - take in the name of the video file
     - type: String - take in the file type of the video file
     */
    
    public func createBackgroundVideo(name: String, type: String) {
        createBackground(name: name, type: type)
    }
    
    /*
      createBackgroundVideo(name: String, type: String, alpha: CGFloat) function:
      - name: String - take in the name of the video file
      - type: String - take in the file type of the video file
      - alpha: CGFloat - take in the desired alpha/darkness of the background video
    */
    
    public func createBackgroundVideo(name: String, type: String, alpha: CGFloat) {
        createAlpha(alpha: alpha)
        
        createBackground(name: name, type: type)
    }
    
    private func createAlpha(alpha: CGFloat) {
        let overlayView = UIView(frame: self.frame)
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = alpha
        self.addSubview(overlayView)
        self.sendSubview(toBack: overlayView)
    }
    
    private func createBackground(name: String, type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        if let player = player {
            player.actionAtItemEnd = AVPlayerActionAtItemEnd.none;
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.frame
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.layer.insertSublayer(playerLayer, at: 0)
            
            // Set observer for when video ends and loop video infinitely
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            player.seek(to: kCMTimeZero)
            player.play()
        }
    }
    
    @objc private func playerItemDidReachEnd() {
        player?.seek(to: kCMTimeZero)
    }
}
