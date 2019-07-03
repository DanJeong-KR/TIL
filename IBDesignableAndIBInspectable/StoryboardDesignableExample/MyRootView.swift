//
//  MyRootView.swift
//  StoryboardDesignableExample
//
//  Created by chang sic jung on 18/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

@IBDesignable
class MyRootView: UIView {

    let baseView = UIView()
    let customButton = CustomButton(type: .system)
    let emojiSelectorView = EmojiSelectorView()
    
    // MARK: - Initialize
    
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        baseView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        insertSubview(baseView, at: 0)
        
        baseView.addSubview(emojiSelectorView)
        
        customButton.backgroundColor = .black
        customButton.setTitle("MyButton", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        baseView.addSubview(customButton)
    }
    
    // MARK: - AutoLayout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.frame = bounds
    }
    
    
    var didUpdateConstraint = false
    override func updateConstraints() {
        if !didUpdateConstraint {
            emojiSelectorView.translatesAutoresizingMaskIntoConstraints = false
            customButton.translatesAutoresizingMaskIntoConstraints = false
            
            let constraints: [NSLayoutConstraint] = [
                emojiSelectorView.centerXAnchor.constraint(equalTo: centerXAnchor),
                emojiSelectorView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100),
                emojiSelectorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -150),
                emojiSelectorView.heightAnchor.constraint(equalToConstant: 100),
                
                customButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                customButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
                customButton.widthAnchor.constraint(equalToConstant: 100),
                customButton.heightAnchor.constraint(equalToConstant: 100),
            ]
            for const in constraints {
                const.isActive = true
            }
            didUpdateConstraint = true
        }
        
        // 구현 가장 마지막에 호출하라는 애플문서의 경고.
        super.updateConstraints()
    }

}
