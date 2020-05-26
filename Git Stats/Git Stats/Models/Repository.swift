//
//  Repository.swift
//  Git Stats
//
//  Created by Jack Smith on 25/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

struct Repository: Codable {
    var name: String
    var language: String
    var stars: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case language
        case stars = "stargazers_count"
    }
}
