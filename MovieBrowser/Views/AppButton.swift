//
//  AppButton.swift
//  MovieBrowser
//
//  Created by UHP Mac on 25/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    @IBInspectable var background: UIColor = Colors.primary {
        didSet {
            self.backgroundColor = background
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = self.background
        self.layer.cornerRadius = self.cornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        self.setTitleColor(UIColor.white, for: .normal)
        self.contentEdgeInsets.top = 10
        self.contentEdgeInsets.bottom = 10
        self.contentEdgeInsets.left = 20
        self.contentEdgeInsets.right = 20
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.pulsate()
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        
        layer.add(pulse, forKey: "pulse")
    }
    
}
