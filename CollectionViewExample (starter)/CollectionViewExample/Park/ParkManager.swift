//
//  ImageManager.swift
//  CollectionViewExample
//
//  Created by giftbot on 27/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

struct ParkManager {
  enum ImageType {
    case state, nationalPark
  }
  
  static func imageNames(of type: ImageType) -> [String] {
    switch type {
    case .state:
      // Park의 모든 location 데이터를 문자열로 변환
      return Park.Location.allCases
          .filter { list.map { $0.location }.contains($0) }
          .map { $0.rawValue }
    case .nationalPark:
      return list.map { $0.name }
    }
  }
  
  static let list: [Park] = [
    Park(location: .alaska, name: "Denali"),
    Park(location: .alaska, name: "Katmai"),
    Park(location: .alaska, name: "Kenai Fjords"),
    Park(location: .arizona, name: "Grand Canyon"),
    Park(location: .california, name: "Joshua Tree"),
    Park(location: .california, name: "Sequoia"),
    Park(location: .california, name: "Yosemite"),
    Park(location: .colorado, name: "Great Sand Dunes"),
    Park(location: .colorado, name: "Mesa Verde"),
    Park(location: .colorado, name: "Rocky Mountains"),
    Park(location: .maine, name: "Acadia"),
    Park(location: .montana, name: "Glacier"),
    Park(location: .montana, name: "Yellowstone"),
    Park(location: .northCarolina, name: "Smokey Mountains"),
    Park(location: .ohio, name: "Cuyahoga Valley"),
    Park(location: .utah, name: "Arches"),
    Park(location: .utah, name: "Bryce Canyon"),
    Park(location: .utah, name: "Zion"),
    Park(location: .virginia, name: "Shenandoah"),
    Park(location: .washington, name: "Mount Rainier"),
    Park(location: .washington, name: "North Cascades"),
    Park(location: .washington, name: "Olympic"),
  ]
}
