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
        textFiled.rightView = textfiledBtn
        //emojiView.backgroundColor = .red
//        textFiled.backgroundColor = .white
        textFiled.placeholder = "댓글 달기..."
        // add subview 했어?
        addSubviews([emojiView,textFiled])
        // delegate 있어?
        
        // layout 설정
        autolayouts()
    }
    
    private func autolayouts() {
        emojiView.layout.leading().trailing().top(constant: 10).bottom(equalTo: textFiled.topAnchor)
        textFiled.layout.leading().trailing().bottom(constant: 10)
        textFiled.heightAnchor.constraint(equalTo: emojiView.heightAnchor).isActive = true
    }
    
    @objc private func commentBtnDidTapped(_ sender: Any) {
        
    }
    
}
