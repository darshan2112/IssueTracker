//
//  Search+CoreDataProperties.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var keyWord: String?
    @NSManaged public var issues: NSSet?

}

// MARK: Generated accessors for issues
extension Search {

    @objc(addIssuesObject:)
    @NSManaged public func addToIssues(_ value: Issue)

    @objc(removeIssuesObject:)
    @NSManaged public func removeFromIssues(_ value: Issue)

    @objc(addIssues:)
    @NSManaged public func addToIssues(_ values: NSSet)

    @objc(removeIssues:)
    @NSManaged public func removeFromIssues(_ values: NSSet)

}

extension Search {
    
    class func searchResultsWith(searchKeyword keyword: String, issues: [IssueObject],  inManagedObjectContext context: NSManagedObjectContext) -> Search? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Search")
        request.predicate = NSPredicate(format: "keyWord = %@", keyword)
        
        if let searchResults = (try? context.fetch(request))?.first as? Search {
            return searchResults
        } else if let searchResult = NSEntityDescription.insertNewObject(forEntityName: "Search", into: context) as? Search {
            
            searchResult.keyWord = keyword
            
            for issueObject in issues {
                
                if let issue = Issue.issueWith(issueObject: issueObject, inManagedObjectContext: context){
                    
                    searchResult.addToIssues(issue)
                }
                
            }
            
            return searchResult
            
        } else {
            return nil
        }
        
    }

}
