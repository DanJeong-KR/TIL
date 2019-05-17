
import AudioToolbox.AudioServices
import UIKit

class SecondViewController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
//        button.setTitleColor(.lightGray, for: .normal)
//        button.setTitleColor(.init(red: 18/255, green: 90/255, blue: 153/255, alpha: 1.0), for: .selected) // 선택됫을 때 색깔 바꾸기
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(nextAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        let closeImage = UIImage(named: "btnClose")!
        button.setImage(closeImage, for: .normal)
        button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var animationLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.text = "Name your workspace"
        lb.alpha = 0.0 // 애니메이션 적용할 거라. 처음에 투명한 아이
        return lb
    }()

    private let wsNameTextField: UITextField = {
        let textField = UITextField()
        let attrString = NSAttributedString( // 속성 적용된 String
            string: "Name your workspace",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5),]
        )
        textField.attributedPlaceholder = attrString
        textField.font = UIFont.systemFont(ofSize: 22, weight: .light) // weight 속성!
        textField.enablesReturnKeyAutomatically = true // 입력을 안했을 때 return 키 동작 안하게
        textField.borderStyle = .none
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private var floatingCenterYConst: NSLayoutConstraint!
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    private var indicatorViewLeadingConst: NSLayoutConstraint!
    
    private var inputText: String = ""
    private var editText: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        
        configure()
        autolayouts()
    }
    
    private func configure() {
        view.addSubviews([
            nextButton,
            closeButton,
            wsNameTextField,
            animationLabel,
            activityIndicatorView,])
        
        wsNameTextField.delegate = self
        wsNameTextField.becomeFirstResponder()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func autolayouts() {
        
        nextButton.layout.top().trailing(constant: -16)
        closeButton.layout.top().leading(constant: 16)
        wsNameTextField.layout.leading(constant: 16).trailing(constant: -16).centerY(constant: -115)
        //animationLabel.layout.leading(constant: 16).trailing(constant: -16).centerY(constant: -140)
        
        animationLabel.layout.leading(constant: 16)
        let defaultCenterYConst = animationLabel.centerYAnchor.constraint(equalTo: wsNameTextField.centerYAnchor)
        defaultCenterYConst.priority = UILayoutPriority(500) // priority 설정해주려고 상수에 저장했네
        defaultCenterYConst.isActive = true
        
        floatingCenterYConst = animationLabel.centerYAnchor
            .constraint(equalTo: wsNameTextField.centerYAnchor, constant: -30) // 애니메이션 적용
        floatingCenterYConst.priority = .defaultLow
        floatingCenterYConst.isActive = true
        
        activityIndicatorView.layout.centerY(equalTo: wsNameTextField.centerYAnchor)
        indicatorViewLeadingConst = activityIndicatorView.leadingAnchor.constraint(equalTo: wsNameTextField.leadingAnchor)
        indicatorViewLeadingConst.isActive = true
    }
    
    
    @objc private func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func vibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        // kSystemSoundID_Vibrate 는 4095 라는 숫자임.
    }

    @objc private func nextAction(_ sender: Any) {
        guard nextButton.isSelected, let text = wsNameTextField.text
            else { return vibration() } // void 함수라 return 에 사용 가능
        
        guard !activityIndicatorView.isAnimating else { return }
        
        let textSize = (text as NSString).size(withAttributes: [.font: wsNameTextField.font!])
        indicatorViewLeadingConst.constant = textSize.width + 8
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicatorView.stopAnimating()
            // 다음 뷰 컨트롤러 띄우는 코드
            // text 를 다음 뷰 컨트롤러에게 넘기기
            
            let vc = ThirdViewController()
            vc.receivedText = text
            vc.textSize = (text as NSString).size(withAttributes: [.font: self.wsNameTextField.font!])
            self.show(vc, sender: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension SecondViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
        nextButton.isSelected = !replacedText.isEmpty
        
        //range 정보를 반영해서 textfiled 의 text 관리하기
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        if replacedText.isEmpty {
                            // 오토레이아웃 두개 잡고 애니메이션에서 priority 설정으로 애니메이션을 구현하기
                            self.floatingCenterYConst.priority = .defaultLow
                            self.animationLabel.alpha = 0.0
                        } else {
                            self.floatingCenterYConst.priority = .defaultHigh
                            self.animationLabel.alpha = 1.0
                        }
                        // 애니메이션에서 오토레이아웃 설정을 하면 발생하는 시점문제를 해결한다.
                        self.view.layoutIfNeeded()
        })
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextAction(nextButton)
        return true
    }
}
