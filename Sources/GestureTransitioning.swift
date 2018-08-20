//
//  GestureTransitioning.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

public final class GestureTransitioning {
    
    let type: TransitionType
    let presentingGesture: GestureAnimating?
    let dismissingGesture: GestureAnimating?
    
    deinit {
        Movin.dp("GestureTransitioning - deinit")
    }
    
    public init(_ type: TransitionType, _ presentingGesture: GestureAnimating?, _ dismissingGesture: GestureAnimating? = nil) {
        self.type = type
        self.presentingGesture = presentingGesture
        self.dismissingGesture = dismissingGesture
    }
    
    func currentType() -> TransitionType {
        Movin.dp("GestureTransitioning - currentType")
        if self.presentingGesture?.gesture == nil { return self.type.reversedType }
        return self.type
    }
    
    func gesture(_ type: TransitionType) -> GestureAnimating? {
        Movin.dp("Transition - gesture type: \(type)")
        return type.isPresenting ? self.presentingGesture : self.dismissingGesture
    }
    
    func hasGesture(_ type: TransitionType) -> Bool {
        Movin.dp("Transition - hasGesture type: \(type)")
        if type.isPresenting { return self.presentingGesture?.gesture != nil }
        return self.dismissingGesture?.gesture != nil
    }
    
    func finishTransition(_ type: TransitionType, _ didComplete: Bool) {
        Movin.dp("Transition - finishTransition type: \(type), didComplete: \(didComplete)")
        if !didComplete { return }
        self.gesture(type)?.unregisterGesture()
    }
}
