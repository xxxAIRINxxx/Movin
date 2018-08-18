//
//  ModalViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import UIKit
import Movin

final class ModalViewController: UIViewController {
    
    @IBOutlet private(set) weak var contentView: UIView!
    
    deinit {
        print("denit ModalViewController")
    }

    @IBAction private func tapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
