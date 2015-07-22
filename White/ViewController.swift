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
    
    enum Music: String {
        case Cafe = "cafe"
        case Rain = "rain"
        case Night = "night"
        
        var backgroundColor: UIColor {
            switch self {
            case .Cafe:
                return UIColor(red:0.29, green:0, blue:0, alpha:1)
            case .Rain:
                return UIColor(red:0, green:0.4, blue:0.63, alpha:1)
            case .Night:
                return UIColor(white: 0.2, alpha: 1)
            }
        }
    }
    var currentMusic: Music = .Cafe {
        didSet {
            currentMusicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(currentMusic.rawValue, ofType: "m4a")!)
        }
    }
    
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
            
            if playing {
                audioPlayer.play()
            }
        }
    }
    var audioPlayer: AVAudioPlayer!
    var playing = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            
            if playing {
                audioPlayer.play()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = self.currentMusic.backgroundColor
                    self.playButton.tintColor = UIColor.whiteColor()
                }
            }
            else {
                audioPlayer.stop()
                
                UIView.animateWithDuration(animationDuration) {
                    self.view.backgroundColor = UIColor.whiteColor()
                    self.playButton.tintColor = self.currentMusic.backgroundColor
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
        
        currentMusic = .Rain
        
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
            currentMusic = .Cafe
        case rainMusicButton:
            currentMusic = .Rain
        case nightMusicButton:
            currentMusic = .Night
        default:
            break
        }
        
        let upperView = UIView(frame: view.frame)
        upperView.backgroundColor = playing ? currentMusic.backgroundColor : UIColor.whiteColor()
        
        let upperPlayButton = UIButton(frame: playButton.frame)
        upperPlayButton.setImage(UIImage(named: currentMusic.rawValue), forState: .Normal)
        upperPlayButton.tintColor = playing ? UIColor.whiteColor() : currentMusic.backgroundColor
        upperView.addSubview(upperPlayButton)
        
        view.insertSubview(upperView, belowSubview: musicSwitcherStackView)
        
        let maskLayer = CALayer()
        maskLayer.frame = sender.convertRect(sender.bounds, toView: view)
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        maskLayer.cornerRadius = maskLayer.frame.height / 2
        upperView.layer.mask = maskLayer
        
        UIView.animateWithDuration(1, animations: {
            maskLayer.bounds = CGRectApplyAffineTransform(upperView.bounds, CGAffineTransformMakeScale(2, 2))
            maskLayer.cornerRadius = maskLayer.frame.width / 2
        }, completion: { _ in
            self.view.backgroundColor = self.playing ? self.currentMusic.backgroundColor : UIColor.whiteColor()
            self.playButton.setImage(UIImage(named: self.currentMusic.rawValue), forState: .Normal)
            self.playButton.tintColor = self.playing ? UIColor.whiteColor() : self.currentMusic.backgroundColor

            upperView.removeFromSuperview()
        })
    }

    @IBAction func playTapped(sender: UIButton) {
        playing = !playing
    }
}

