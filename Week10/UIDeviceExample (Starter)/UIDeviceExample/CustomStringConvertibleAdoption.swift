//
//  CustomStringConvertibleAdoption.swift
//  UIDeviceExample
//
//  Created by giftbot on 04/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

extension UIDevice.BatteryState: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unknown: return "unknown"
    case .unplugged: return "unplugged"
    case .charging: return "charging"
    case .full: return "full"
    @unknown default: fatalError()
    }
  }
}

extension UIUserInterfaceIdiom: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unspecified: return "unspecified"
    case .phone: return "phone"
    case .pad: return "pad"
    case .tv: return "tv"
    case .carPlay: return "carPlay"
    @unknown default: fatalError()
    }
  }
}

extension UIDeviceOrientation: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unknown: return "unknown"
    case .portrait: return "portrait"
    case .portraitUpsideDown: return "portraitUpsideDown"
    case .landscapeLeft: return "landscapeLeft"
    case .landscapeRight: return "landscapeRight"
    case .faceUp: return "faceUp"
    case .faceDown: return "faceDown"
    @unknown default: fatalError()
    }
  }
}

extension UIInterfaceOrientation: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unknown: return "unknown"
    case .portrait: return "portrait"
    case .portraitUpsideDown: return "portraitUpsideDown"
    case .landscapeLeft: return "landscapeLeft"
    case .landscapeRight: return "landscapeRight"
    @unknown default: fatalError()
    }
  }
}
