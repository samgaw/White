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
    
    var audioPlayer: AVAudioPlayer!
    var playing = false {
        didSet {
            if playing {
                audioPlayer.play()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = UIColor.blackColor()
                    self.playButton.tintColor = UIColor.whiteColor()
                }
            }
            else {
                audioPlayer.stop()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = UIColor.whiteColor()
                    self.playButton.tintColor = UIColor.blackColor()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playTapped(sender: UIButton) {
        playing = !playing
    }
}

