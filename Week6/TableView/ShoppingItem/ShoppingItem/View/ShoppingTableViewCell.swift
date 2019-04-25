//
//  ShoppingTableViewCell.swift
//  ShoppingItem
//
//  Created by chang sic jung on 25/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

protocol ShoppingTableViewCellDelegate: class {
    func sendEvent(_ cell: ShoppingTableViewCell)
}

class ShoppingTableViewCell: UITableViewCell {
    
    //weak var delegate: ShoppingTableViewCellDelegate?

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        //delegate?.sendEvent(self)
        NotificationCenter.default.post(name: NSNotification.Name("addButtonTapped"), object: nil, userInfo: ["cell":self])
    }
}
