import UIKit
import XCPlayground
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 580))
view.backgroundColor = UIColor.white
XCPShowView(identifier: "preview", view: view)

let v = UIView(frame: CGRect(x: 0,y: 0,width: 44,height: 44))
v.backgroundColor = UIColor.red
view.addSubview(v)

UIView.animate(withDuration: 0.5) { () -> Void in
    v.center = view.center
}
