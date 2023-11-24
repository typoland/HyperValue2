import Foundation
import SwiftUI

struct Graph {

    var colorValueFor : (_ x:Int, _ xRange: Int, _ y: Int, _ yRange: Int) -> CGColor

    func draw(xSteps: Int, ySteps:Int) -> (_ size: CGSize, _ context: CGContext) -> Void {
        return { imageSize, context in
            let stepSize = CGSize(width: imageSize.width / CGFloat(xSteps),
                                          height: imageSize.height / CGFloat(ySteps))
            
            for x in 0..<(xSteps) {
                for y in 0..<(ySteps) {
                    let rgba = colorValueFor(x, xSteps, y, ySteps)
                    context.setFillColor(rgba)
                    context.fill([rect(x:x, y:y)])
                }
            }
            
            func rect(x: Int, y: Int) -> CGRect {
                
                let origin = CGPoint(x: CGFloat(x) * stepSize.width,
                                     y: CGFloat(y) * stepSize.height)
                return CGRect(origin: origin, 
                              size: CGSize(width: stepSize.width+0.3,
                                           height: stepSize.height+0.3))
            }
        }
    }
}

extension NSImage {
    convenience init(size: CGSize, actions: (CGSize, CGContext) -> Void) {
        self.init(size: size)
        lockFocusFlipped(false)        
        actions(size, NSGraphicsContext.current!.cgContext)
        unlockFocus()
    }
}

