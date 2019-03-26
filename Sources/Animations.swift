//
//  Animations.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/01.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

public struct AnimationDirection {
    
    public let duration: TimeInterval
    public let isFoward: Bool
    
    public init(_  duration: TimeInterval, _ isFoward: Bool) {
        self.duration = duration
        self.isFoward = isFoward
    }
}

public protocol AnimationCompatible: class {
    
    var delayFactor: CGFloat { get set }
    
    func beforeAnimation()
    func aninmate(_ animationDirection: AnimationDirection)
    
    // optional
    func finishAnimation(_ isFoward: Bool, _ didComplete: Bool)
    
    // optional
    func interactiveAnimate(_ fractionComplete: CGFloat)
    func finishInteractiveAnimation(_ interactiveTransitioning: InteractiveTransitioning)
}

public extension AnimationCompatible {
    
    @discardableResult func delay(_ v: CGFloat) -> Self {
        self.delayFactor = v
        return self
    }
    
    func interactiveAnimate(_ fractionComplete: CGFloat) {}
    
    func finishInteractiveAnimation(_ interactiveTransitioning: InteractiveTransitioning) {}
}

public protocol ValueAnimationCompatible: AnimationCompatible {
    
    associatedtype Value
    
    var fromValue: Value { get set }
    var toValue: Value { get set }
    var currentValue: Value { get set }
}

public extension ValueAnimationCompatible {
    
    @discardableResult func from(_ v: Value) -> Self {
        self.fromValue = v
        return self
    }
    
    @discardableResult func to(_ v: Value) -> Self {
        self.toValue = v
        return self
    }
    
    func beforeAnimation() {
        self.currentValue = self.fromValue
    }
    
    func aninmate(_ animationDirection: AnimationDirection) {
        self.currentValue = self.toValue
    }
    
    func finishAnimation(_ isFoward: Bool, _ didComplete: Bool) {
        if isFoward {
            self.currentValue = didComplete ? self.toValue : self.fromValue
        } else {
            self.currentValue = didComplete ? self.fromValue : self.toValue
        }
    }
}

public final class AlphaAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGFloat
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value = 0
    public var currentValue: Value { didSet { self.view.alpha = self.currentValue } }
    
    deinit {
        Movin.dp("AlphaAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        self.fromValue = view.alpha
        self.currentValue = self.fromValue
    }
}

public final class BackgroundColorAnimation : ValueAnimationCompatible {
    
    public typealias Value = UIColor
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.backgroundColor = self.currentValue } }
    
    deinit {
        Movin.dp("BackgroundColorAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.backgroundColor ?? .white
        self.toValue = view.backgroundColor ?? .white
        self.currentValue = self.fromValue
    }
}

public final class FrameAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGRect
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.frame = self.currentValue } }
    
    deinit {
        Movin.dp("FrameAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.frame
        self.toValue = view.frame
        self.currentValue = self.fromValue
    }
}

public final class PointAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGPoint
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.frame.origin = self.currentValue } }
    
    deinit {
        Movin.dp("PointAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.frame.origin
        self.toValue = view.frame.origin
        self.currentValue = self.fromValue
    }
}

public final class SizeAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGSize
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.frame.size = self.currentValue } }
    
    deinit {
        Movin.dp("SizeAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.frame.size
        self.toValue = view.frame.size
        self.currentValue = self.fromValue
    }
}

public final class CornerRadiusAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGFloat
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.layer.cornerRadius = self.currentValue } }
    
    deinit {
        Movin.dp("CornerRadiusAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.layer.cornerRadius
        self.toValue = view.layer.cornerRadius
        self.currentValue = self.fromValue
        self.view.clipsToBounds = true
    }
    
    public func aninmate(_ animationDirection: AnimationDirection) {
        if #available(iOS 11.0, *) {
            self.currentValue = self.toValue
        } else {
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.duration = animationDirection.duration
            animation.fromValue = animationDirection.isFoward ? self.fromValue : self.toValue
            animation.toValue = animationDirection.isFoward ? self.toValue : self.fromValue
            animation.isRemovedOnCompletion = true
            self.view.layer.add(animation, forKey: "cornerRadius")
            self.view.layer.cornerRadius = animationDirection.isFoward ? self.toValue : self.fromValue
        }
    }
    
    public func interactiveAnimate(_ fractionComplete: CGFloat) {
        if #available(iOS 11.0, *) {
        } else {
            self.currentValue = self.toValue * fractionComplete
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.duration = 0.01
            animation.fromValue = self.currentValue
            animation.toValue = self.currentValue
            self.view.layer.add(animation, forKey: "cornerRadius")
        }
    }
    
    public func finishInteractiveAnimation(_ interactiveTransitioning: InteractiveTransitioning) {
        if #available(iOS 11.0, *) {
        } else {
            let duration = interactiveTransitioning.duration * (1.0 - interactiveTransitioning.transition.movin.animator.fractionComplete)
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.duration = duration.toDouble
            animation.fromValue = self.currentValue
            if interactiveTransitioning.type.isPresenting {
                animation.toValue = interactiveTransitioning.isCompleted ? self.toValue : self.fromValue
            } else {
                animation.toValue = interactiveTransitioning.isCompleted ? self.fromValue : self.toValue
            }
            animation.isRemovedOnCompletion = true
            self.view.layer.add(animation, forKey: "cornerRadius")
            
            if interactiveTransitioning.type.isPresenting {
                self.view.layer.cornerRadius = interactiveTransitioning.isCompleted ? self.toValue : self.fromValue
            } else {
                self.view.layer.cornerRadius = interactiveTransitioning.isCompleted ? self.fromValue : self.toValue
            }
        }
    }
}

public final class TransformAnimation : ValueAnimationCompatible {
    
    public typealias Value = CGAffineTransform
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    public var fromValue: Value
    public var toValue: Value
    public var currentValue: Value { didSet { self.view.transform = self.currentValue } }
    
    deinit {
        Movin.dp("TransformAnimation - deinit")
    }
    
    public init(_ view: UIView) {
        self.view = view
        
        self.fromValue = view.transform
        self.toValue = view.transform
        self.currentValue = self.fromValue
    }
}

public class CustomAnimation : AnimationCompatible {
    
    public let view: UIView
    
    public var delayFactor: CGFloat = 0
    
    private var animation: (UIView) -> Swift.Void
    private var before: ((UIView) -> Swift.Void)?
    private var finish: ((Bool, Bool) -> Swift.Void)?
    
    deinit {
        Movin.dp("CustomAnimation - deinit")
    }
    
    public init(_ view: UIView, _ animation: @escaping (UIView) -> Swift.Void) {
        self.view = view
        self.animation = animation
    }
    
    @discardableResult public func configureBefore(_ before: ((UIView) -> Swift.Void)? = nil) -> CustomAnimation {
        self.before = before
        return self
    }
    
    @discardableResult public func configureFinish(_ finish: ((Bool, Bool) -> Swift.Void)? = nil) -> CustomAnimation {
        self.finish = finish
        return self
    }
    
    public func beforeAnimation() {
        self.before?(self.view)
    }
    
    public func aninmate(_ animationDirection: AnimationDirection) {
        self.animation(self.view)
    }
    
    public func finishAnimation(_ isFoward: Bool, _ didComplete: Bool) {
        self.finish?(isFoward, didComplete)
    }
}

// WIP

//public class CustomTimingAnimation : AnimationCompatible {
//
//    public let view: UIView
//    public let duration: TimeInterval
//
//    public var delayFactor: CGFloat = 0
//
//    private var before: ((UIView) -> Swift.Void)?
//    private var finish: ((Bool, Bool) -> Swift.Void)?
//
//    deinit {
//        Movin.dp("CustomAnimation - deinit")
//    }
//
//    public init(_ view: UIView, _ duration: TimeInterval) {
//        self.view = view
//        self.duration = duration
//    }
//
//    @discardableResult public func configureBefore(_ before: ((UIView) -> Swift.Void)? = nil) -> CustomTimingAnimation {
//        self.before = before
//        return self
//    }
//
//    @discardableResult public func configureFinish(_ finish: ((Bool, Bool) -> Swift.Void)? = nil) -> CustomTimingAnimation {
//        self.finish = finish
//        return self
//    }
//
//    public func beforeAnimation() {
//        self.before?(self.view)
//    }
//
//    public func aninmate(_ animationDirection: AnimationDirection) {
//
//    }
//
//    public func finishAnimation(_ isFoward: Bool, _ didComplete: Bool) {
//        self.finish?(isFoward, didComplete)
//    }
//
//    public func interactiveAnimate(_ fractionComplete: CGFloat) {
//    }
//}
