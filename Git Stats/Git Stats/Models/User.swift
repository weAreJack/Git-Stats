//
//  User.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var username: String?
    var name: String?
    var bio: String?
    var location: String?
    var noOfRepos: Int?
    var noFollowers: Int?
    var noFollowing: Int?
    var profileImageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case name
        case bio
        case location
        case noOfRepos = "public_repos"
        case noFollowers = "followers"
        case noFollowing = "following"
        case profileImageUrlString = "avatar_url"
    }
}
