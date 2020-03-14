//
//  ResponseData.swift
//  VenturusTest
//
//  Created by Albert Oliveira on 14/03/20.
//  Copyright © 2020 Albert Oliveira. All rights reserved.
//

import Foundation

class ResponseData: Decodable {
    
    var cats: [Cat]?
    
    enum CodingKeys: String, CodingKey {
        case cats = "data"
    }
    
}
