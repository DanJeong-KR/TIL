import UIKit


class GestureViewController: UIViewController {
    
    var partRect: CGRect?
    var isMakeNewSpace: Bool = true
    
    @IBOutlet weak var tapCountLabel: UILabel!
    var touchCount:Int = 0 {
        didSet {
            tapCountLabel.text = String(self.touchCount)
        }
    }
    
    @IBOutlet weak var coordinateLabel: UILabel!
    var coordinate: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            coordinateLabel.text = "( \(self.coordinate.x) , \(self.coordinate.y) )"
        }
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        
        coordinate = touchPoint
        
        if isMakeNewSpace {
            
            partRect = CGRect(x: touchPoint.x - 20, y: touchPoint.y - 20, width: 40, height: 40)
            isMakeNewSpace = false
        }
        
        if partRect!.contains(touchPoint) {
            touchCount += 1
        }else {
            isMakeNewSpace = true
            touchCount = 1
        }
    }
}
