//
//  AnotherFile.swift
//  AccessControl
//
//  Created by giftbot on 17/09/2018.
//  Copyright © 2018 giftbot. All rights reserved.
//

import Foundation

fileprivate class FileprivateClass {
  public var publicProperty = 10
  internal var internalProperty = 20
  fileprivate var fileprivateProperty = 30
  private var privateProperty = 40
  
  var defaultProperty = 50
}


// 동일 파일 내에서는 fileprivate 클래스에 접근 가능
class SameFileAnotherClass {
  private let someProperty = FileprivateClass()
    
  func someFunction() {
    let fileprivateClass = FileprivateClass()
    print(fileprivateClass.publicProperty)
    print(fileprivateClass.internalProperty)
    print(fileprivateClass.fileprivateProperty)
//    print(fileprivateClass.privateProperty)  // 접근 불가
    
    print(fileprivateClass.defaultProperty)  // = fileprivate
  }
}
