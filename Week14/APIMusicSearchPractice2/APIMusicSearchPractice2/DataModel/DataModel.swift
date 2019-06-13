//
//  DataModel.swift
//  APIMusicSearchPractice2
//
//  Created by chang sic jung on 11/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

struct Search: Codable {
    
    let results: [Music]
    
    struct Music: Codable {
        let artistName: String?
        let trackName: String?
        let image: Data?
        
        private enum CodingKeys: String, CodingKey {
            case artistName
            case trackName
            case image = "artworkUrl100"
        }
    }
}
