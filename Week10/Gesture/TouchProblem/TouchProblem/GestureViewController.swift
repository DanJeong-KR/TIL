import UIKit


class GestureViewController: UIViewController {
    
    var rect: CGRect?
    var enableRectActive: Bool = true
    
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
    
    func makeRectActive(_ touchPoint: CGPoint) {
        if enableRectActive {
            rect = CGRect(x: touchPoint.x - 20, y: touchPoint.y - 20, width: 40, height: 40)
            enableRectActive = false
        }
    }
    
    func touchWork(_ touchPoint: CGPoint){
        if rect!.contains(touchPoint) {
            touchCount += 1
        }else {
            enableRectActive = true
            touchCount = 1
        }
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        
        coordinate = touchPoint
        
        makeRectActive(touchPoint)
        touchWork(touchPoint)
    }
}
