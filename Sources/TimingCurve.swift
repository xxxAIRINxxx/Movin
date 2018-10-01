//
//  TimingCurve.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public class TimingCurve: NSObject, UITimingCurveProvider {
    
    public let timingCurveType: UITimingCurveType
    
    public let cubicTimingParameters: UICubicTimingParameters?
    
    public let springTimingParameters: UISpringTimingParameters?
    
    public override init() {
        self.timingCurveType = .cubic
        self.cubicTimingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        self.springTimingParameters = nil
        
        super.init()
    }
    
    public init(cubic: UICubicTimingParameters, spring: UISpringTimingParameters? = nil) {
        if spring != nil {
            self.timingCurveType = .composed
        } else {
            self.timingCurveType = .cubic
        }
        self.cubicTimingParameters = cubic
        self.springTimingParameters = spring
        
        super.init()
    }
    
    public init(curve: UIView.AnimationCurve, dampingRatio: CGFloat, initialVelocity: CGVector? = nil) {
        self.timingCurveType = .composed
        self.cubicTimingParameters = UICubicTimingParameters(animationCurve: curve)
        
        if let v = initialVelocity {
            self.springTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: v)
        } else {
            self.springTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio)
        }
        
        super.init()
    }
    
    public init(curve: UIView.AnimationCurve, damping: CGFloat, initialVelocity: CGVector, mass: CGFloat, stiffness: CGFloat) {
        self.timingCurveType = .composed
        self.cubicTimingParameters = UICubicTimingParameters(animationCurve: curve)
        self.springTimingParameters = UISpringTimingParameters(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: initialVelocity)
        
        super.init()
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.timingCurveType.rawValue, forKey: "timingCurveType")
    }

    public required init?(coder aDecoder: NSCoder) {
        self.timingCurveType = UITimingCurveType(rawValue: aDecoder.decodeObject(forKey: "timingCurveType") as? Int ?? 0) ?? .cubic
        self.cubicTimingParameters = UICubicTimingParameters(animationCurve: .easeInOut)
        self.springTimingParameters = nil
    }
}
