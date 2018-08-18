//
//  PushTransitionViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import UIKit
import Movin

final class PushTransitionViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    
    private var movin: Movin?
    
    @IBAction private func tapButton() {
        self.movin = Movin(1.0)
        
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.view.layoutIfNeeded()
        
        self.movin!.addAnimations([
            self.contentView.mvn.alpha.to(0.5),
            self.contentView.mvn.backgroundColor.to(UIColor.red),
            self.contentView.mvn.cornerRadius.to(15),
            detail.view.mvn.frame.to(CGRect(x: 0, y: 0, width: detail.view.frame.size.width, height: detail.view.frame.size.height)),
            detail.view.mvn.alpha.from(0).to(1),
            detail.contentView.mvn.backgroundColor.to(UIColor.black),
            ])
        
        self.navigationController?.delegate = self.movin!.configureTransition(self, detail).configureCompletion { [weak self] type, didComplete in
            print("didComplete : \(didComplete)")
            if type.isDismissing && didComplete {
                self?.movin = nil
            }
        }
        self.navigationController?.pushViewController(detail, animated: true)
    }

}
