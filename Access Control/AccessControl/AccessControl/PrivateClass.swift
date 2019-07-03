//
//  SomeClass.swift
//  AccessControl
//
//  Created by giftbot on 17/09/2018.
//  Copyright © 2018 giftbot. All rights reserved.
//

import Foundation

private class PrivateClass {
  public var publicProperty = 100
  internal var internalProperty = 200
  fileprivate var fileprivateProperty = 300
  private var privateProperty = 400
  
  // default 는 fileprivate 처럼 동작
  var defaultProperty = 500
  
  func someFileprivateFunction() {
  }
  private func somePrivateFunction() {
  }
}


class SomeOtherClass {
  // fileprivate 또는 private 으로 설정 필요
  fileprivate let privateClass = PrivateClass()
//  private let privateClass = PrivateClass()

  func someFunction() {
    let privateClass = PrivateClass()
    print(privateClass.publicProperty)
    print(privateClass.internalProperty)
    print(privateClass.fileprivateProperty)
//    print(privateClass.privateProperty)  // 접근 불가
    
    print(privateClass.defaultProperty)    // = fileprivate
    
    privateClass.someFileprivateFunction()
//    privateClass.somePrivateFunction()   // 접근 불가
  }
}


// Swift 4 부터 Private 레벨의 접근 수준 확장
// 버전 4 이전에는 같은 파일 내에서라도 extension 을 추가하기 위해서 fileprivate 사용
extension PrivateClass {
  var extendVariable: String {
    return ""
  }
}
