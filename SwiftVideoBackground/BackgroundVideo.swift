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
    
    public func createBackgroundVideo(url: String, type: String) {
        let path = Bundle.main.path(forResource: url, ofType: type)
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.none;
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.layer.insertSublayer(playerLayer, at: 0)
        
        // Set observer for when video ends and loop video infinitely
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: kCMTimeZero)
        player!.play()
    }
    
    public func createBackgroundVideo(url: String, type: String, alpha: CGFloat) {
        createAlpha(alpha: alpha)
        
        let path = Bundle.main.path(forResource: url, ofType: type)
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.none;
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.layer.insertSublayer(playerLayer, at: 0)
        
        // Set observer for when video ends and loop video infinitely
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: kCMTimeZero)
        player!.play()
    }
    
    private func createAlpha(alpha: CGFloat) {
        let overlayView = UIView(frame: self.frame)
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = alpha
        self.addSubview(overlayView)
        self.sendSubview(toBack: overlayView)
    }
    
    @objc private func playerItemDidReachEnd() {
        player!.seek(to: kCMTimeZero)
    }
}
