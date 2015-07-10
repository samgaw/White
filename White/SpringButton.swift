//
//  SpringButton.swift
//  White
//
//  Created by Dongyuan Liu on 2015-07-09.
//  Copyright © 2015 Sike. All rights reserved.
//

import UIKit

@IBDesignable
class SpringButton: UIButton {
    
    let width: CGFloat = 225
    let height: CGFloat = 276
    
    @IBInspectable var multiplier: CGFloat = 1.2
    @IBInspectable var duration: Double = 1
    @IBInspectable var damping: CGFloat = 0.5
    @IBInspectable var springVelocity: CGFloat = 0.5
    
    override var highlighted: Bool {
        didSet {
            UIView.animateWithDuration(duration as NSTimeInterval,
                delay: 0,
                usingSpringWithDamping: damping,
                initialSpringVelocity: springVelocity,
                options: [],
                animations: {
                    self.invalidateIntrinsicContentSize()
                    self.superview?.layoutIfNeeded()
                },
                completion: nil)
        }
    }

    override func intrinsicContentSize() -> CGSize {
        return highlighted ? CGSizeMake(width * multiplier, height * multiplier) : CGSizeMake(width, height)
    }

}
