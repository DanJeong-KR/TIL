//
//  DataModel.swift
//  URLSessionExample
//
//  Created by chang sic jung on 10/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

struct Todo: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
