//
//  Issue+CoreDataProperties.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//
//

import Foundation
import CoreData


extension Issue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }

    @NSManaged public var title: String?
    @NSManaged public var patchUrl: String?
    @NSManaged public var number: String?
    @NSManaged public var id: Int32
    @NSManaged public var state: String?
    @NSManaged public var user: User?

}

extension Issue {
    
    class func issueWith(issueObject object: IssueObject, inManagedObjectContext context: NSManagedObjectContext) -> Issue? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Issue")
        request.predicate = NSPredicate(format: "id = %d", object.id)
        
        if let issue = (try? context.fetch(request))?.first as? Issue {
            return issue
        } else if let newIssue = NSEntityDescription.insertNewObject(forEntityName: "Issue", into: context) as? Issue {
            
            newIssue.id = Int32(object.id)
            newIssue.number = String(object.number)
            newIssue.patchUrl = object.pullRequest?.patch_url
            newIssue.title = object.title
            newIssue.state = object.state
            
            if let user = object.user {
                newIssue.user = User.userWithObject(userObject: user, inManagedObjectContext: context)
            }

            return newIssue
        } else {
            return nil
        }
    }
    
}
