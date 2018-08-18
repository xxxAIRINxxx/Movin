//
//  InteractiveTransitionViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import UIKit
import Movin

final class InteractiveTransitionViewController: UIViewController {
    
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
        
        let modal = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        modal.view.layoutIfNeeded()
        
        self.movin!.addAnimations([
            self.contentView.mvn.alpha.to(0.5),
            self.contentView.mvn.frame.to(CGRect(x: 100, y: 150, width: 30, height: 30)),
            self.contentView.mvn.backgroundColor.to(UIColor.red),
            self.contentView.mvn.cornerRadius.to(15),
            modal.view.mvn.frame.to(CGRect(x: 0, y: 0, width: modal.view.frame.size.width, height: modal.view.frame.size.height)),
            modal.view.mvn.alpha.from(0).to(0.8),
            modal.contentView.mvn.backgroundColor.to(UIColor.black),
            ])
        
        modal.modalPresentationStyle = .custom
        let gesture = GestureAnimating(self.contentView, .bottom, self.view.mvn.halfSize)
        modal.transitioningDelegate = self.movin!.configureTransition(self.navigationController!, modal, GestureTransitioning(.present, gesture)).configureCompletion { [weak self] type, didComplete in
            print("didComplete : \(didComplete)")
            if type.isDismissing && didComplete {
                self?.setup()
            }
        }
    }
}
