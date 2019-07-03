//
//  NationalPark.swift
//  CollectionViewExample
//
//  Created by giftbot on 29/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

struct Park {
  enum Location: String, CaseIterable {
    case alaska = "Alaska"
    case arizona = "Arizona"
    case california = "California"
    case colorado = "Colorado"
    case maine = "Maine"
    case montana = "Montana"
    case northCarolina = "North Carolina"
    case ohio = "Ohio"
    case utah = "Utah"
    case virginia = "Virginia"
    case washington = "Washington"
  }
  
  let location: Location
  let name: String
}
