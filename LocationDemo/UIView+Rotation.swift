import UIKit

extension UIView {
    
    /**
     Rotate a view by specified degrees
     Lifted from https://stackoverflow.com/questions/21370728/rotate-uiview-around-its-center-keeping-its-size#answer-35656911
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransform.init(rotationAngle: radians)
        self.transform = rotation
    }
}
