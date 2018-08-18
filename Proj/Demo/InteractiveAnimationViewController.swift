//
//  InteractiveAnimationViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import UIKit
import Movin

final class InteractiveAnimationViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    
    private var movin: Movin?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setup()
    }
    
    private func setup() {
        if #available(iOS 11.0, *) {
            self.movin = Movin(1.0, TimingCurve(curve: .easeInOut, dampingRatio: 0.8))
        } else {
            self.movin = Movin(1.0)
        }
        
        self.movin!.addAnimations([
            self.contentView.mvn.alpha.to(0.5),
            self.contentView.mvn.point.to(CGPoint(x: 100, y: 150)),
            self.contentView.mvn.cornerRadius.to(15),
            ])
        
        let gesture = GestureAnimating(self.contentView, .none(self.view), self.view.mvn.halfSize)
        self.movin!.startAnimation(.interactive(gesture))
    }
}
