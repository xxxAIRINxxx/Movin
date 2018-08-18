//
//  DetailViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private(set) weak var contentView: UIView!

    deinit {
        print("denit DetailViewController")
    }
    
    @IBAction private func tapCloseButton() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
