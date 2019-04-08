
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lb_second: UILabel!
    @IBOutlet weak var lb_singleton: UILabel!
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lb_second.text = ud.dictionaryRepresentation()["tf"] as? String
        
        lb_singleton.text = Singleton.shared.x

    }
}
