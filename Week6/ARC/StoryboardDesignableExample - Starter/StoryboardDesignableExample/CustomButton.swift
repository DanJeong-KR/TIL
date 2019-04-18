//
//  CircleButton.swift
//  StoryboardDesignableExample
//
//  Created by 이봉원 on 14/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

/***************************************************
 Xcode 6부터 IBDesignable / IBInspectable 추가
 
 @IBDesignable
 - 코드로 작성한 내용을 런타임이 아닌 컴파일 타임에 스토리보드에서 미리 렌더링하여 볼 수 있도록 해주는 키워드
 
 @IBInspectable
 - 스토리보드의 Attributes Inspector에 원하는 프로퍼티 항목을 추가해 설정할 수 있도록 하는 키워드
 - 반드시 타입을 지정(Type Annotation)해주어야 함
 - 프로퍼티 옵저버 또는 계산 프로퍼티를 이용해 변경사항을 즉시 확인 가능
 - Inspector에서 설정한 값은 User Defined Runtime Attributes에 반영됨
 ***************************************************/


@IBDesignable
final class CustomButton: UIButton {

  @IBInspectable var someValue: Int = 10
  
    // get , set 을 쓰는 이유. 스토리보드에서 수정한 값을 바로바로 확인할 때
  @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }
    
    
  @IBInspectable var borderColor: UIColor? {
    didSet { layer.borderColor = borderColor?.cgColor }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        didSet { layer.shadowColor = shadowColor?.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: -3) {
        didSet { layer.shadowOffset = shadowOffset}
    }
//  var shadowOffset: CGSize = CGSize(width: 0, height: -3)

}
