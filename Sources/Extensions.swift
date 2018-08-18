//
//  Extensions.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    var toCGFloat: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    
    var toDouble: Double { return Double(self) }
}

extension UIViewController {
    
    var isOverContext: Bool {
        switch self.modalPresentationStyle {
        case .currentContext,
             .overFullScreen,
             .overCurrentContext,
             .custom:
            return true
        default:
            return false
        }
    }
}

func sigmoid(x: Double) -> Double {
    return 1.0 / (1.0 + exp(-x))
}

func sigmoidGradient(x: Double) -> Double {
    return (1.0 - sigmoid(x: x)) * sigmoid(x: x)
}

