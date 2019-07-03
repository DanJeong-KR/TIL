//
//  EmojiSelectionView.swift
//  Instagram
//
//  Created by chang sic jung on 18/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class EmojiSelectionView: UIView {

    let emojies = ["😎", "🤢", "👹", "👺", "🎃", "🤖", "👽", "👾", ]
    
    let emojiView = UIView()
    let textFiled = UITextField()
    let textfiledBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("게시", for: .normal)
        btn.addTarget(self, action: #selector(commentBtnDidTapped(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        // 속성들 설정하기
        textFieldConfigure()
        emojiButtonConfigure()
        // add subview 했어?
        addSubviews([emojiView,textFiled])
        // delegate 있어?
        
        // layout 설정
        autolayouts()
    }
    
    private func textFieldConfigure() {
        textFiled.placeholder = "  댓글 달기..."
        textFiled.layer.borderColor = UIColor.lightGray.cgColor
        textFiled.layer.borderWidth = 0.5
        textFiled.layer.cornerRadius = 20
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.rightView = textfiledBtn
        textFiled.rightViewMode = .always
    }
    
    private func emojiButtonConfigure(){
        var btArr: [UIButton] = []
        for emoji in emojies {
            let bt = UIButton(type: .custom)
            bt.setTitle(emoji, for: .normal)
            emojiView.addSubview(bt)
            bt.addTarget(self, action: #selector(emojiBtnDidTapped(_:)), for: .touchUpInside)
            bt.layout.top(equalTo: emojiView.topAnchor).bottom(equalTo: emojiView.bottomAnchor)
            //bt.widthAnchor.constraint(equalToConstant: 45).isActive = true
            btArr.append(bt)
        }
        
        for idx in btArr.indices {
            if idx != 0 {
                btArr[idx].leading(equalTo: btArr[idx-1].trailingAnchor)
            }
            if idx != btArr.count - 1 {
                btArr[idx].widthAnchor.constraint(equalTo: btArr[idx + 1].widthAnchor).isActive = true
            }
        }
        btArr.first!.leading(equalTo: emojiView.leadingAnchor)
        btArr.last!.trailing(equalTo: emojiView.trailingAnchor)
    }
    
    private func autolayouts() {
        emojiView.layout.leading(equalTo: self.leadingAnchor ,constant: 10).trailing(equalTo: self.trailingAnchor, constant: -10).top(constant: 10).bottom(equalTo: textFiled.topAnchor)
        emojiView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFiled.layout.leading(equalTo: self.leadingAnchor, constant: 10).trailing(equalTo: self.trailingAnchor, constant: -10)
        textFiled.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func commentBtnDidTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("commentBtnDidTapped"), object: nil, userInfo: ["text" : textFiled.text!])
    }
    
    @objc private func emojiBtnDidTapped(_ sender: UIButton) {
        textFiled.text! += sender.titleLabel!.text!
    }
}
