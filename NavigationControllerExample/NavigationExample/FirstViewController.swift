

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "FirstVC"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        let barButton = UIBarButtonItem(title: "push", style: .done, target: self, action: #selector(pushViewController(_:)))
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func pushViewController(_ sender: Any) {
        
        let secondVC = SecondViewController()
        
        // push 는 내비게이션과만 연관되 있는 것이기 떄문에 navigationController. 해서 접근한다.
        navigationController?.pushViewController(secondVC, animated: true)
    }


}

