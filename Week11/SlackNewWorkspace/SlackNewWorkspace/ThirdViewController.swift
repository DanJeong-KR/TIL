
// 1 .텍스트 필드에 일정 텍스트 이상 되면 더이상 텍스트 사용하지 못하게.

// 2. error 입력하면 텍스트 필드 흔들기.

import UIKit

class ThirdViewController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.init(red: 18/255, green: 90/255, blue: 153/255, alpha: 1.0), for: .selected) // 선택됫을 때 색깔 바꾸기
        button.isSelected = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(nextAction(_:)), for: .touchUpInside)
        return button
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let closeImage = UIImage(named: "btnBack")!
        button.setImage(closeImage, for: .normal)
        button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var userNoticeUrlLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 13)
        lb.text = "Get a URL (Letters, numbers, and dashed only"
        return lb
    }()
    var userNoticeInputInfoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .lightGray
        lb.text = "This is the address that you'll use to sign in to Slack."
        return lb
    }()
    var userNoticeErrorLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        lb.alpha = 0.0
        lb.text = "This URL is not available. Sorry!"
        return lb
    }()
    var textFieldTailLabel: UILabel = {
        let lb = UILabel()
        let attrString = NSAttributedString( // 속성 적용된 String
            string: ".slack.com",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)]
        )
        lb.font = UIFont.systemFont(ofSize: 22, weight: .light)
        lb.attributedText = attrString
        return lb
    }()
    
    private var tailLabelLeadingConst: NSLayoutConstraint!

    private let wsUrlTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 22, weight: .light) // weight 속성!
        textField.enablesReturnKeyAutomatically = true // 입력을 안했을 때 return 키 동작 안하게
        textField.borderStyle = .none
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.becomeFirstResponder()
        return textField
    }()
    
    var receivedText: String = ""
    
    var textSize: CGSize?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
        configure()
        autolayouts()
    }
    
    private func configure() {
        view.addSubviews([nextButton,
                          backButton,
                          userNoticeUrlLabel,
                          userNoticeInputInfoLabel,
                          userNoticeErrorLabel,
                          wsUrlTextField,
                          textFieldTailLabel,
                          ])
        
        wsUrlTextField.delegate = self
        wsUrlTextField.text = receivedText
    }
    
    private func autolayouts() {
        nextButton.layout.top().trailing(constant: -16)
        backButton.layout.top().leading(constant: 16)
        wsUrlTextField.layout.leading(constant: 16).trailing(constant: -16).centerY(constant: -115)
        
        userNoticeUrlLabel.layout.leading(constant: 16).centerY(equalTo: wsUrlTextField.centerYAnchor, constant: -30)
        
        userNoticeInputInfoLabel.layout.leading(constant: 16).centerY(equalTo: wsUrlTextField.centerYAnchor, constant: 100)
        
        userNoticeErrorLabel.layout.leading(constant: 16).centerY(equalTo: wsUrlTextField.centerYAnchor, constant: 30)
        
        textFieldTailLabel.layout.centerY(equalTo: wsUrlTextField.centerYAnchor)
        
        tailLabelLeadingConst = textFieldTailLabel.leadingAnchor.constraint(equalTo: wsUrlTextField.leadingAnchor)
        tailLabelLeadingConst.isActive = true
        tailLabelLeadingConst.constant = textSize!.width + 1
        
    }
    
    @objc private func nextAction(_ sender: UIButton) {
        let text = wsUrlTextField.text ?? ""
        if text == "error" {
            userNoticeErrorLabel.alpha = 1.0
            
            // 텍스트필드 흔들기
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: wsUrlTextField.center.x - 10, y: wsUrlTextField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: wsUrlTextField.center.x + 10, y: wsUrlTextField.center.y))
            wsUrlTextField.layer.add(animation, forKey: "position")
        }
    }
    
    @objc private func cancelAction(_ sender: Any) {
        //dismiss(animated: true)
        //presentingViewController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
        
    }
}

extension ThirdViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
        
        if replacedText.count < 20 {
            nextButton.isSelected = !replacedText.isEmpty
            
            textSize = (replacedText as NSString).size(withAttributes: [.font : wsUrlTextField.font!])
            tailLabelLeadingConst.constant = textSize!.width + 1
        }else {
            return false
        }

        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextAction(nextButton)
        return true
    }
}
