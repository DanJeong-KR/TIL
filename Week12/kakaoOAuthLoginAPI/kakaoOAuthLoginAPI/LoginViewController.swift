//
//  LoginViewController.swift
//  kakaoOAuthLoginAPI
//
//  Created by chang sic jung on 20/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func didTappedLoginButton(_ sender: Any) {
        
        guard let session = KOSession.shared() else { return }
        
        session.isOpen() ? session.close() : ()
        
        session.open { (error) in
            if !session.isOpen() {
                //에러
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        print("cancelled")
                    default:
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("Login Success")
                // UIApplication.shared.delegate 가 AppDelegate 임
//                ((UIApplication.shared.delegate) as? AppDelegate)?.setupRootViewController()
                AppDelegate.instance.setupRootViewController()
            }
        } 
    }

}
