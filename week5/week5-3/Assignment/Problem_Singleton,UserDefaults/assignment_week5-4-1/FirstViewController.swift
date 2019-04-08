
// singleton
// userdefaults
// 로 화면 이동해서 데이터 받기


import UIKit

class FirstViewController: UIViewController {

    let ud = UserDefaults.standard
    
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var tf_singleton: UITextField!
    
    let single = Singleton.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults
        tf.text = "test"
        UserDefaults.standard.set(tf.text, forKey: "tf")
        
        // Delegate
        
        // Singleton
        single.x = "singleton text"
        tf_singleton.text = single.x
    }
    
    
    
    
    @IBAction func unwindToToFirst(_ unwindSegue: UIStoryboardSegue) {
        
    }
}


