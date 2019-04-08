//
//  ViewController.swift
//  LoginPage
//
//  Created by chang sic jung on 05/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPass: UIImageView!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    var inputEmail = ""
    var inputPass = ""
    
    // 텍스트 필드 키보드 올라오는 카운트
    var keyboardIsOn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 비밀번호 설정하기.
        UserDefaults.standard.set("a920506@gmail.com", forKey: "email")
        UserDefaults.standard.set("qwer", forKey: "password")
        
        // fastcampus image 부분
        let mainImage = UIImageView(image: UIImage(named: "fastcampus_logo"))
        mainImage.frame.size = CGSize(width: 280, height: 70)
        mainImage.frame.origin = CGPoint(x: self.view.center.x - mainImage.frame.size.width/2, y: 100)
        self.view.addSubview(mainImage)
        
        // 밑에 네모 세개
        let squareImage_1 = UIView()
        squareImage_1.frame.size = CGSize(width: 30, height: 30)
        squareImage_1.frame.origin = CGPoint(x: self.view.center.x - 60, y: mainImage.frame.origin.y + 80)
        squareImage_1.backgroundColor = .red
        squareImage_1.layer.cornerRadius = 5
        
        let squareImage_2 = UIView()
        squareImage_2.frame.size = CGSize(width: 30, height: 30)
        squareImage_2.frame.origin = CGPoint(x: self.view.center.x - 15, y: mainImage.frame.origin.y + 80)
        squareImage_2.backgroundColor = .red
        squareImage_2.layer.cornerRadius = 5
        
        let squareImage_3 = UIView()
        squareImage_3.frame.size = CGSize(width: 30, height: 30)
        squareImage_3.frame.origin = CGPoint(x: self.view.center.x + 30, y: mainImage.frame.origin.y + 80)
        squareImage_3.backgroundColor = .red
        squareImage_3.layer.cornerRadius = 5
        
        self.view.addSubview(squareImage_1)
        self.view.addSubview(squareImage_2)
        self.view.addSubview(squareImage_3)
        
        // 이메일 부분
        imgEmail.image = UIImage(named: "email")
        tfEmail.delegate = self
        
        
        // 비밀번호 부분
        imgPass.image = UIImage(named: "password")
        tfPass.delegate = self
        tfPass.isSecureTextEntry = true
        
        // Sign In Button
        signButton.layer.cornerRadius = 20
    }
    
    // segue 로 화면 이동 부분
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // 텍스트 필드에 입력된 텍스트가 미리 설정해둔 이메일, 비밀번호와
        // 같으면 -> 화면을 이동하고
        // 그렇지 않으면 -> 화면을 일시적으로 빨간색에서 다시 돌아오도록 애니메이션 주기.
        
        if inputEmail == UserDefaults.standard.dictionaryRepresentation()["email"] as! String &&
            inputPass == UserDefaults.standard.dictionaryRepresentation()["password"] as! String &&
            inputEmail.count < 16 && inputEmail.count > 3 &&
            inputPass.count < 16 && inputPass.count > 3{
            
            keyboardIsOn = false // 화면 이동할 때 키보드 상태를 false 로 초기화 시켜준다.
            
            return true
        }else {
            self.view.backgroundColor = .red
            UIView.animate(withDuration: 0.5) {
                self.view.backgroundColor = .white
            }
            
            let alert = UIAlertController(title: "로그인 실패", message: "아이디와 패스워드가 맞지 않습니다.\n ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            
            self.present(alert, animated: false)
            
            
            return false
        }
    }
    
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        print(keyboardIsOn)
    }
}

// MARK: -- TextField Delegate

extension FirstViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if keyboardIsOn == false {
            UIView.animate(withDuration: 0.2) {
                self.view.frame.origin.y -= 200
                self.keyboardIsOn = true
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 텍스트 필드에 문자가 입력되는 순간마다 input 으로 저장하고, 백스페이스 누르면 input 에서 지우게 한다.
        // 텍스트 필드가 firstVC 에 2개 있으므로 tag 로 구별해준다.
        switch textField.tag {
        case 0://email
            if string == "" {
                inputEmail.removeLast() // 백스페이스 눌렀을 때 문자열 지워지도록.
            }else if inputEmail.count > 20 { // 최대 문자 20 까지 제한하기
                textField.deleteBackward()
            }else {
                inputEmail += string
            }
        case 1://password
            if string == "" {
                inputPass.removeLast()
            }else if inputPass.count > 20 { // 최대 비밀번호 20자리까지 제한.
                textField.deleteBackward()
            }
            else {
                inputPass += string
            }
        default:
            break
        }
        
        print(inputEmail)
        print(inputPass)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // return 키를 누르면 키보드가 내려가고
        // 화면도 같이 내려가도록 한다.
        textField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y += 200
            self.keyboardIsOn = false
        }
        
        return true
    }
    
    
    
}


