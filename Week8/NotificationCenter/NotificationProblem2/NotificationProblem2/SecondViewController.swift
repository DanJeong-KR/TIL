

import UIKit

class SecondViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.frame = CGRect(x: 100, y: 150 , width: 300, height: 100)
        view.addSubview(label)
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(textfield(sender:)), name: Notification.Name("textfield"), object: nil)
        
    }
    
    @objc func textfield(sender: Notification) {
        guard let userInfo = sender.userInfo as? [String:String] else { print("userInfoError"); return }
        
        label.text = userInfo["text"]
        
    }
    


}
