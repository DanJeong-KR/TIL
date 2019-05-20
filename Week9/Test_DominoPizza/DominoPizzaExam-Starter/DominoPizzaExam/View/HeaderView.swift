//
//  HeaderView.swift
//  DominoPizzaExam
//
//  Created by chang sic jung on 26/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let headerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    init(frame:CGRect, imageString: String) {
        super.init(frame: frame)
        addSubview(headerImageView)
        headerImageView.frame = frame
        headerImageView.image = UIImage(named: imageString)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
