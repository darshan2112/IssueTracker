//
//  UserObject.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//

import Foundation

class UserObject: Codable {
    
    var userName: String?
    var id: Int
    
}

extension UserObject {
    
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case id
    }
    
}
