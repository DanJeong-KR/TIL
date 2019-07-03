
import UIKit


class CellDataModel {
    
    var name: String?
    var count: Int?
    var image: UIImage?
    var stocks: Int = 0
    
    init(name: String, count: Int, image: UIImage) {
        self.name = name
        self.count = count
        self.image = image
    }
}




