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
    
    var audioPlayer: AVAudioPlayer!
    var playing = false {
        didSet {
            if playing {
                audioPlayer.play()
            }
            else {
                audioPlayer.stop()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playTapped(sender: UIButton) {
        playing = !playing
    }
}

