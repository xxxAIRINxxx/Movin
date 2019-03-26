//
//  Shorthands.swift
//  Movin
//
//  Created by xxxAIRINxxx on 2018/08/02.
//  Copyright © 2018 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

public protocol MovinExtensionCompatible {
    associatedtype CompatibleType
    
    var mvn: CompatibleType { get }
}

public struct MovinExtensionCompatibleWrapped<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public extension MovinExtensionCompatible {
    
    var mvn: MovinExtensionCompatibleWrapped<Self> {
        return MovinExtensionCompatibleWrapped(self)
    }
}

extension UIView: MovinExtensionCompatible {}

public extension MovinExtensionCompatibleWrapped where Base : UIView {
    
    var alpha: AlphaAnimation { return AlphaAnimation(self.base) }
    
    var backgroundColor: BackgroundColorAnimation { return BackgroundColorAnimation(self.base) }
    
    var frame: FrameAnimation { return FrameAnimation(self.base) }
    
    var point: PointAnimation { return PointAnimation(self.base) }
    
    var size: SizeAnimation { return SizeAnimation(self.base) }
    
    var transform: TransformAnimation { return TransformAnimation(self.base) }
    
    var cornerRadius: CornerRadiusAnimation { return CornerRadiusAnimation(self.base) }
}

public extension MovinExtensionCompatibleWrapped where Base : UIView {
    
    var halfSize: CGSize { return self.base.bounds.size.mvn.halfSize }
}

extension CGSize: MovinExtensionCompatible {}

public extension MovinExtensionCompatibleWrapped where Base == CGSize {
    
    var halfSize: CGSize { return CGSize(width: self.base.width * 0.5, height: self.base.height * 0.5) }
}
