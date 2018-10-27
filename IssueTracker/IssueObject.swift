//
//  Issue.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//

import Foundation

class IssueObject : Codable {
    
    var title : String?
    var id: Int
    var user: UserObject?
    var state: String?
    var number: Int
    var pullRequest: PullRequestObject?
    
}

extension IssueObject {
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case user
        case state
        case number
        case pullRequest = "pull_request"
    }
    
}
