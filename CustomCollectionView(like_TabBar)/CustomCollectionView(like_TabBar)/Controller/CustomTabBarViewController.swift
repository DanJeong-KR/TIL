//
//  CustomTabBarViewController.swift
//  CustomCollectionView(like_TabBar)
//
//  Created by chang sic jung on 19/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
let menuTitles = ["menu1", "menu2", "menu3", "menu4"]

class CustomTabBarViewController: UIViewController {

    let menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubviews([menuView])
        menuView.menuBarView.menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        menuView.layout.top().bottom().leading().trailing()
        
        
    }
    


}
