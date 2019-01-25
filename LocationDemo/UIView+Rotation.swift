import UIKit

extension UIView {
    
    func rotate(degrees: CGFloat) {
        //Adapted from https://stackoverflow.com/questions/21370728#answer-35656911
        let radians = degrees / 180.0 * CGFloat.pi
        self.transform = CGAffineTransform.init(rotationAngle: radians)
    }
}
