
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var id = ""
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch id {
        case "dog":
            imgView.image = UIImage(named: "dog.jpg")
        case "cat":
            imgView.image = UIImage(named: "cat.jpg")
        case "bird": imgView.image = UIImage(named: "bird.jpeg")
        default:
            print("잘못된 식별자")
        }
        
    }
    @IBAction func addAll(_ sender: UIButton) {
        /*
        guard let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as? FirstViewController else { return }
         */
        clickCount += 1
    }
    
    
}
