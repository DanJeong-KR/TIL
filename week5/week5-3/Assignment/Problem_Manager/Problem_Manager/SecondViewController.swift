import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: CGFloat(Singleton.shared.red), green: CGFloat(Singleton.shared.green), blue: CGFloat(Singleton.shared.blue), alpha: 0.5)
    }
}
