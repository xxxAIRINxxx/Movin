//
//  ViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/01.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import UIKit
import Movin

final class ViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    
    private var movin: Movin?
    
    private var originalFrame: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.originalFrame = self.contentView.frame
    }
    
    @IBAction private func tapButton() {
        if #available(iOS 11.0, *) {
            self.movin = Movin(1.0, TimingCurve(curve: .easeInOut, dampingRatio: 0.8))
        } else {
            self.movin = Movin(1.0)
        }
        
        self.movin!.addAnimations([
            self.contentView.mvn.alpha.from(1.0).to(0.5),
            self.contentView.mvn.backgroundColor.from(.blue).to(.red),
            self.contentView.mvn.frame.from(self.originalFrame).to(CGRect(x: 100, y: 150, width: 30, height: 30)),
            self.contentView.mvn.cornerRadius.from(0).to(15),
            ])
        
        self.movin!.startAnimation()
    }
}
