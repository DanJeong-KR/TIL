//
//  SecondViewController.swift
//  NotificationCenterExample
//
//  Created by giftbot on 28/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

// 4.2 버전보다 아래 방식 / Notification.Name 자체에 원하는 방식 지정
extension Notification.Name {
    static let randomColorNotification =
    Notification.Name("RandomColorNotification")
    static let plusNotification =
        Notification.Name("PlusNotification")
}

extension SecondViewController {
    static var randomColorNotification: Notification.Name {
        return Notification.Name(rawValue: "RandomColorNotification")
    }
    static var plusNotification: Notification.Name {
        return Notification.Name("PlusNotification")
    }
}

final class SecondViewController: UIViewController {
    
  static var test = ""
  @IBOutlet private weak var colorView: UIView!
  @IBOutlet private weak var numberLabel: UILabel!
  
  @IBOutlet private weak var colorNotiButton: UIButton!
  @IBOutlet private weak var plusNotiButton: UIButton!
  
  let notiCenter = NotificationCenter.default
    
    deinit {
        
        //notiCenter.removeObserver(self)
        notiCenter.removeObserver(self, name: .randomColorNotification, object: nil)
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addNotificationObserver()
    
    
  }
  
  // MARK: - Add Notification Oberserver
  
  func addNotificationObserver() {
    /***************************************************
     addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
     - 파라미터 정보
     > observer: 옵저버를 등록할 객체
     > selector: 지정한 알림이 발생했을 때 반응할 메서드
     > name: 알림을 구분하기 위한 이름
     > object: 특정 객체를 지정하면 그것을 통해 발생하는 알림만 등록, nil이면 전체
     
     - 중복하여 등록하면 메서드 중복 실행
     ***************************************************/
    
    // ColorNotification
    notiCenter.addObserver(self, selector: #selector(didReceiveRandomColorNotification(_:)),
                           name: Notification.Name(rawValue: "RandomColorNotification"),
                           object: nil)
    
    // Plus Notification
    
    notiCenter.addObserver(self, selector: #selector(didReceivePlusNotification(_:)),
                           // 1.직접생성
                           //name: Notification.Name(rawValue: "PlusNotification"),
        //name:.plusNotification ,
        // 3 . 알림을 보내는 객체가 가진 속성 // 알림을 보내는 객체를 넣어주므로 주체를 알 수가 있다.
        name: SecondViewController.plusNotification,
        object: nil)
    
  }
  
  
  // MARK: - Random Color Notification
  
  @IBAction func postRandomColorNotification(_ sender: Any) {
    let noti = Notification(name: Notification.Name(rawValue: "RandomColorNotification"))
    notiCenter.post(noti)
  }
  
  @objc func didReceiveRandomColorNotification(_ sender: Notification) {
    print(sender)
    
    let r = CGFloat.random(in: 0...1)
    let g = CGFloat.random(in: 0...1)
    let b = CGFloat.random(in: 0...1)
    
    colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    
    // Noti정보
    print("name : ", sender.name)
    print("object : ", sender.object ?? "nil")
    print("userInfo : ",sender.userInfo ?? "nil")
  }
  
  
  
  // MARK: - Plus Notification
  
  @IBAction func postPlusNotification(_ sender: Any) {
    // 알림 정보 + 이벤트 발생 객체 정보도 같이 준다.
    //notiCenter.post(name: SecondViewController.plusNotification, object: sender)
    
    notiCenter.post(name: .plusNotification, object: sender, userInfo: ["AdditionalNumber":5])
  }
  
  @objc func didReceivePlusNotification(_ sender: Notification) {
    guard let number = Int(numberLabel.text ?? "0"),
        let userInfo = sender.userInfo as? [String : Int]
    else { return }
    numberLabel.text = "\(number + 1)"
    // Noti정보
    print("name : ", sender.name)
    print("object : ", sender.object ?? "nil")
    print("userInfo : ",sender.userInfo ?? "nil")
    
    print(userInfo["AdditionalNumber"]!)
    numberLabel.text = "\(number + 1 + userInfo["AdditionalNumber"]!)"
  }
  
  
  // MARK: - Remove Notification Observer
  
  func removeNotificationObserver() {
    /***************************************************
     removeObserver(<#T##observer: Any##Any#>)
     - 지정 객체에 등록한 모든 옵저버를 제거
     
     removeObserver(<#T##observer: Any##Any#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
     - 지정 객체에 등록한 옵저버 중 특정 이름을 가진 것만 선택하여 제거
     - object가 nil일 경우, 해당 이름을 가진 옵저버 모두 제거
       object에 특정 객체를 지정할 경우 해당 객체로 등록한 옵저버에 대해서만 제거
     
     > 일반적으로
     viewDidLoad <-> deinit
     viewWill/DidAppear <-> viewWill/DidDisappear
     ***************************************************/
  }
}

