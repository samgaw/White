//
//  ViewController.swift
//  White
//
//  Created by Dongyuan Liu on 2015-07-08.
//  Copyright © 2015 Sike. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    let animationDuration = 0.4
    let darkGrayColor = UIColor(white: 0.2, alpha: 1)
    
    var audioPlayer: AVAudioPlayer!
    var playing = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            
            if playing {
                audioPlayer.play()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = self.darkGrayColor
                    self.playButton.tintColor = UIColor.whiteColor()
                }
            }
            else {
                audioPlayer.stop()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = UIColor.whiteColor()
                    self.playButton.tintColor = self.darkGrayColor
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rain", ofType: "m4a")!)
        audioPlayer = AVAudioPlayer()
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: sound)
        }
        catch _ {}
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        
        playing = false
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if playing {
            return .LightContent
        }
        else {
            return .Default
        }
    }


    @IBAction func playTapped(sender: UIButton) {
        playing = !playing
    }
}

