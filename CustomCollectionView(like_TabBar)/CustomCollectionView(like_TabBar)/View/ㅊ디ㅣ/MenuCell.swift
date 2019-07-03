

import UIKit

class MenuCell: UICollectionViewCell {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = "Text"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = .lightGray
        return lb
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = self.isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.layout.centerX().centerY()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
