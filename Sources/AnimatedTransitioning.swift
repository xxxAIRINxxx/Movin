//
//  AnimatedTransitioning.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/01.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

public final class AnimatedTransitioning : NSObject {
    
    public fileprivate(set) weak var transition: Transition!
    public let type: TransitionType
    
    deinit {
        Movin.dp("AnimatedTransitioning - deinit")
    }

    public init( _ transition: Transition, _ type: TransitionType) {
        self.transition = transition
        self.type = type

        super.init()
    }
}

extension AnimatedTransitioning : UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Movin.dp("AnimatedTransitioning - transitionDuration")
        return self.transition.movin.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        Movin.dp("AnimatedTransitioning - animateTransition")
        self.transition.prepareTransition(self.type, transitionContext)
        let type = self.type
        self.transition.movin.animator.addCompletion { [weak self] position in
            switch position {
            case .current:
                break
            default:
                self?.transition.finishTransition(type, true, transitionContext.containerView)
                transitionContext.completeTransition(true)
            }
        }
        
        self.interruptibleAnimator(using: transitionContext).startAnimation()
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
          
        return self.transition.movin.animator
    }
}
