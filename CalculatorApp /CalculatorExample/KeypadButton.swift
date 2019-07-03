
import UIKit

@IBDesignable
final class KeypadButton: UIButton {
    
//    var cornerRadius: CGFloat = 0 {
//        didSet { layer.cornerRadius = cornerRadius}
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
}
