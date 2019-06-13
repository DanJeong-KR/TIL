

import UIKit

extension UIButton {
    func addTarget(action: Selector) {
        guard let vc = parentViewController else {
            fatalError("addSubview 메서드 호출 이후에 사용해야 함")
        }
        addTarget(vc, action: action, for: .touchUpInside)
    }
    
    // button.addTarget(self, action: #selector(abs(_:)), for: .touchUpInside)
    // 에서
    // button.addTarget(action: #selector(abs(_:)))
}
