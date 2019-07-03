

import UIKit

class FirstViewController: UIViewController {

    let textFiled = UITextField()
    
    var text: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textFiled)
        
        textFiled.delegate = self
        textFiled.backgroundColor = .white
        textFiled.placeholder = "text를 입력하세요!"
        textFiled.frame = CGRect(x: 40, y: 150, width: 300, height: 50)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        text = textFiled.text ?? ""
        NotificationCenter.default.post(name: Notification.Name("textfield"), object: nil, userInfo: ["text":text])
    }
    
}

extension FirstViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

