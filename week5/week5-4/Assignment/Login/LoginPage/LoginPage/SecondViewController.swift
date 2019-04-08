//
//  SecondViewController.swift
//  LoginPage
//
//  Created by chang sic jung on 05/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lbEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 이메일과 비밀번호가 일치해야 secondVC 로 화면을 이동하므로 라벨에 표시만 해주면 된다.
        
        lbEmail.text = (UserDefaults.standard.dictionaryRepresentation()["email"] as? String) ?? ""
    }

}
