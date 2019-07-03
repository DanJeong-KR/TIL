//
//  InputCommentView.swift
//  Instagram
//
//  Created by Wi on 24/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class InputCommentView: UIView {
    
    // MARK: - Properties
    
    var emojis = ["😁","😂","👾","😡","😍","❤️","🙌🏿","🐈"]
    var buttons = [UIButton]()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.placeholder = " 댓글 달기..."
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layer.cornerRadius = 20
        textField.font = UIFont.systemFont(ofSize: 15)
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addCommentButtonDidTap(_:)), for: .touchUpInside)
        button.setTitle("게시", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // MARK: - Methods
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: other func
    
    private func configure(){
        self.addSubview(textField)
        buttons = createEmojiBtns(emojis)
        textField.delegate = self
        
        // MARK: textField autolayout
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textField.topAnchor.constraint(equalTo: self.buttons[0].bottomAnchor).isActive = true
        
    }
    
    // 버튼들을 이모지배열의 개수 만큼 만들고 오토레이아웃을 잡아 배열로 반환하는 함수
    func createEmojiBtns(_ emojiArr: [String]) -> [UIButton]{
        var buttons = [UIButton]()
        for i in emojiArr{
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(i, for: .normal)
            self.addSubview(button)
            print(Int(self.frame.width) / emojiArr.count)
            button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.addTarget(self, action: #selector(emojiButtonDidTap(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        let magin: CGFloat = 15
        buttons.first?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: magin).isActive = true
        buttons.last?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -magin).isActive = true
        for i in 1..<buttons.count - 1{
            buttons[i].leadingAnchor.constraint(equalTo: buttons[i - 1].trailingAnchor,constant: magin).isActive = true
        }
        return buttons
    }
    
    // MARK: Action
    
    // 게시버튼을 눌렀을때 실행되는 함수
    @objc func addCommentButtonDidTap(_ sender: UIButton){
        // 텍스트 필드가 비어 있지 않을 때만
        if !textField.text!.isEmpty{
            //노티피케이션으로 알림을 보냅니다.
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addCommentDidTap"), object: nil)
            //텍스트 필드 지워주기
            textField.text = nil
            return
        }
        print("textField Empty")
    }
    
    // 이모지 버튼이 눌렸을때 실행함수
    @objc func emojiButtonDidTap(_ sender: UIButton){
        
        textField.text = (textField.text! + sender.titleLabel!.text!)
    }
    
    
}

extension InputCommentView: UITextFieldDelegate{
    //키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
