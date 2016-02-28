//
//  VideoViewController.swift
//  HugeBeer
//
//  Created by Luis Armando Chávez Soto on 28/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController {

    private var moviePlayer : MPMoviePlayerController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playVideo()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.playVideo()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.moviePlayer?.stop()
        self.moviePlayer?.view.removeFromSuperview()
    }
    
    private func playVideo() ->Bool {
        
        let path:NSURL = NSBundle.mainBundle().URLForResource("iphone", withExtension: "mp4")!       //take path of video
        
        
        moviePlayer = MPMoviePlayerController(contentURL: path)
        //asigning video to moviePlayer
        
        if let player = moviePlayer {
            player.view.frame = self.view.bounds
            //setting the video size to the view size
            
            player.controlStyle = MPMovieControlStyle.None
            //Hiding the Player controls
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerDidFinishPlaying:" , name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)

            
            player.prepareToPlay()
            //Playing the video
            
            
            player.repeatMode = .None
            //Repeating the video
            
            player.scalingMode = .AspectFill
            //setting the aspect ratio of the player
            
            
            self.view.insertSubview(player.view, belowSubview: self.view)
            
            //adding the player view to viewcontroller
            return true
            
        }
        return false
    }
    
    func moviePlayerDidFinishPlaying(notification: NSNotification) {
        self.performSegueWithIdentifier("loginSegue", sender: nil)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
