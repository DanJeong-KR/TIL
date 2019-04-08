/*
 
 ingleton 에 red, green, blue 변수 생성.
 
 firstview 에 UISlider 를 세개 생성하고 슬라이더 각각의 값을 Singleton 에 각각 저장.
 
 secondview 에 backgroundcolor 를 singleton 에서 red, green, blue 값을 참조하여 보여주세요.
 
 (코드로 구현하시오.)
 
 */

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var slideRed: UISlider!
    @IBOutlet weak var slideGreed: UISlider!
    @IBOutlet weak var slideBlue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let single = Singleton.shared
        
        slideRed.addTarget(self, action: #selector(redAction), for: .valueChanged)
        slideGreed.addTarget(self, action: #selector(greenAction), for: .valueChanged)
        slideBlue.addTarget(self, action: #selector(blueAction(sender:)), for: .valueChanged)
    }
    
    @objc func redAction(_ sender: UISlider) {
        
        Singleton.shared.red = sender.value
    }
    
    @objc func greenAction(sender: UISlider) {
        
        Singleton.shared.green = sender.value
    }
    
    @objc func blueAction(sender: UISlider) {
        
        Singleton.shared.green = sender.value
    }
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        
    }

}

