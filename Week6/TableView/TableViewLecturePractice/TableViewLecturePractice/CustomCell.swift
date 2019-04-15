//
//  CustomCell.swift
//  TableViewLecturePractice
//
//  Created by chang sic jung on 15/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func customCell(_ customCell: CustomCell, didTapButton: UIButton)
}

final class CustomCell: UITableViewCell { // final 상속 하지 않을 거다. + 속도 조금 빨라지는 효과.
    
    weak var delegate: CustomCellDelegate?
    
    let button = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        button.setTitle("MyButton", for: .normal)
        button.backgroundColor = .yellow
        
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("띠옹")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.frame = CGRect(x: frame.width - 120, y: 10, width: 80, height: frame.height - 20)
    }
    
    // 뷰에서 오토레이아웃 잡을 때는 여기서
    override func updateConstraints() {
        super.updateConstraints()
        
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        delegate?.customCell(self, didTapButton: sender)
    }
}
