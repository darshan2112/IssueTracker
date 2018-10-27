//
//  User+CoreDataProperties.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var userName: String?

}

extension User {
    class func userWithObject(userObject object: UserObject, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "id = %@", String(object.id))
        
        if let user = (try? context.fetch(request))?.first as? User {
            return user
        } else if let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User {
            newUser.id = String(object.id)
            newUser.userName = object.userName
            return newUser
        } else {
            return nil
        }
    }
}

