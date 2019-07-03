//
//  ViewController.swift
//  URLScheme
//
//  Created by giftbot on 2019. 5. 4..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBAction private func openSetting(_ sender: Any) {
    print("\n---------- [ openSettingApp ] ----------\n")
    guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
    
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    }else {
        UIApplication.shared.open(url)
    }
  }
  
  @IBAction private func openMail(_ sender: Any) {
    print("\n---------- [ openMail ] ----------\n")
    //let scheme = "mailto:someone@mail.com" // 메일 앱이 가지고 있는 scheme 과 받는 사람 지정
    let scheme = "mailto:someone@mail.com?cc=foo@bar.com&subject=title&body=MyText"
    guard let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url)
    
//    guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
//
//    if #available(iOS 10.0, *) {
//        UIApplication.shared.open(url)
//    }else {
//        UIApplication.shared.open(url)
//    }
  }

  @IBAction private func openMessage(_ sender: Any) {
    print("\n---------- [ openMessage ] ----------\n")
    let url = URL(string: "sms:010-8833-2683&body=hello")! // 받는사람 지정
    guard UIApplication.shared.canOpenURL(url) else {
        return
    }
    UIApplication.shared.open(url)
  }
  
  @IBAction private func openWebsite(_ sender: Any) {
    print("\n---------- [ openWebsite ] ----------\n")
    let url = URL(string: "https://google.com")! //
    guard UIApplication.shared.canOpenURL(url) else {
        return
    }
    UIApplication.shared.open(url)
  }
  
    // MARK: - 여기부터 서드파티 앱
    // iOS 9.0 이상부터 서드파티 앱은 화이트 리스트 등록해야 한다. LSApplicationQueriesSchemes
    
  @IBAction private func openFacebook(_ sender: Any) {
    print("\n---------- [ openFacebook ] ----------\n")
    
    let url = URL(string: "fb://")! //
    guard UIApplication.shared.canOpenURL(url) else {
        return
    }
    UIApplication.shared.open(url)
  }
  
  @IBAction private func openMyApp(_ sender: Any) {
    print("\n---------- [ openMyApp ] ----------\n")
    let url = URL(string: "Concentration://host?name=tory&age=5")!
    
    guard UIApplication.shared.canOpenURL(url) else {
        return
    }
    UIApplication.shared.open(url)
  }
}




