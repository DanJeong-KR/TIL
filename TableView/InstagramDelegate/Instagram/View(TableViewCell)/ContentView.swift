

import UIKit

protocol ContentViewDelegate: class {
    func rightViewButtinDidTapped(text: String)
}

class ContentView: UIView {
    
    weak var delegate: ContentViewDelegate?

    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    var btArr = [UIButton]()
    
    var imoArr = [String]()
    
    let textField = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btArr = [button1, button2,button3,button4,button5,button6,button7,button8]
        imoArr = ["😄","😅","😍","🤬","👍","💑","👠","🐶"]
        
        // 버튼 이모티콘 설정하기.
        for (idx,value) in btArr.enumerated() {
            addSubview(value)
            value.backgroundColor = .blue
            value.setTitle(imoArr[idx], for: .normal)
            value.addTarget(self, action: #selector(emoAction(sender:)), for: .touchUpInside)
        }
        
        textField.backgroundColor = .red
        addSubview(textField)
        
        // 텍스트 필드의 버튼 설정.
        let button = UIButton(type: .system)
        button.setTitle("게시", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        button.addTarget(self, action:#selector(rightViewDidTapped(sender:)) , for: .touchUpInside)
        
    }
    
    func setUp() {
        
    }
    
    // MARK: - 델리게이트 메소드
    @objc func rightViewDidTapped(sender: UIButton) {
        delegate?.rightViewButtinDidTapped(text: textField.text!)
    }
    
    @objc func emoAction(sender: UIButton) {
        textField.text = textField.text! + (sender.titleLabel?.text)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 텍스트필드 레이아웃 잡기
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)])
        
        // 버튼 레이아웃 잡기
        for i in btArr {
            i.translatesAutoresizingMaskIntoConstraints = false
            i.bottomAnchor.constraint(equalTo: textField.topAnchor).isActive = true
            i.heightAnchor.constraint(equalToConstant: 45).isActive = true
            i.widthAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            button1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor),
            button3.leadingAnchor.constraint(equalTo: button2.trailingAnchor),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor),
            button5.leadingAnchor.constraint(equalTo: button4.trailingAnchor),
            button6.leadingAnchor.constraint(equalTo: button5.trailingAnchor),
            button7.leadingAnchor.constraint(equalTo: button6.trailingAnchor),
            button8.leadingAnchor.constraint(equalTo: button7.trailingAnchor)
            //button8.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
}
