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
    @IBOutlet weak var changeMusicButton: UIButton!
    @IBOutlet weak var musicSwitcherStackView: UIStackView!
    @IBOutlet weak var musicSwitcherTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cafeMusicButton: UIButton!
    @IBOutlet weak var rainMusicButton: UIButton!
    @IBOutlet weak var nightMusicButton: UIButton!
    
    let animationDuration = 0.4
    let darkGrayColor = UIColor(white: 0.2, alpha: 1)
    
    var currentMusicURL: NSURL! {
        didSet {
            audioPlayer = AVAudioPlayer()
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: currentMusicURL)
            }
            catch _ {}
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            
            playing = playing.boolValue
        }
    }
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
    var showingMusicSwitcher = false {
        didSet {
            if showingMusicSwitcher {
                UIView.animateWithDuration(1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 1,
                    options: [],
                    animations: {
                        self.changeMusicButton.alpha = 0
                        self.musicSwitcherStackView.alpha = 1
                        self.musicSwitcherTopConstraint.constant = 8
                        self.view.layoutIfNeeded()
                    },
                    completion: nil)
            }
            else {
                UIView.animateWithDuration(1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 1,
                    options: [],
                    animations: {
                        self.changeMusicButton.alpha = 1
                        self.musicSwitcherStackView.alpha = 0
                        self.musicSwitcherTopConstraint.constant = -50
                        self.view.layoutIfNeeded()
                    },
                    completion: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMusicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rain", ofType: "m4a")!)
        
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

    @IBAction func changeMusic(sender: UIButton) {
        showingMusicSwitcher = !showingMusicSwitcher
    }
    
    @IBAction func musicButtonTapped(sender: UIButton) {
        showingMusicSwitcher = false
        
        switch sender {
        case cafeMusicButton:
            currentMusicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cafe", ofType: "m4a")!)
        case rainMusicButton:
            currentMusicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rain", ofType: "m4a")!)
        case nightMusicButton:
            currentMusicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("night", ofType: "m4a")!)
        default:
            break
        }
    }

    @IBAction func playTapped(sender: UIButton) {
        playing = !playing
    }
}

