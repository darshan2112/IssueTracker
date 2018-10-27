//
//  ViewController.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//

import UIKit
import  Alamofire
import CoreData

class ViewController: UIViewController {

    var organization: String?
    var repository: String?
    
    
    var issues: [Issue]?
    var searchKeyword : String = ""
    
     var context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func getIssuesButtonTapped(_ sender: Any) {
        
        if let org = self.organization, let repository = self.repository {
            //Get issues
            
           self.searchKeyword = org+repository
            self.getIssuesFor(organization: org, repository: repository)
            
        } else {
            self.showAlert(withErrorMessage: "Please provide organization and repository details")
        }
    }
    
    @IBAction func finishedEditingOrganization(_ sender: UITextField) {
        self.organization = sender.text
    }
    
    @IBAction func finishedEditingRepository(_ sender: UITextField) {
        self.repository = sender.text
    }
    
    @IBOutlet weak var organizationTextField: UITextField!
    @IBOutlet weak var repositoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func getIssuesFor(organization: String, repository: String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Search")
        request.predicate = NSPredicate(format: "keyWord = %@", self.searchKeyword)
        
        if let results = (try? context.fetch(request))?.first as? Search{
            
            navigateToIssuesController(withIssues: Array(results.issues!) as! [Issue])
        
        } else {

            let url = "https://api.github.com/repos/\(organization)/\(repository)/issues"
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil).response { (response) in
                
                switch response.response?.statusCode {
                    
                case 200:
                    print("Success")
                    
                    if let data = response.data {
                        
                        if let issues = try? JSONDecoder().decode([IssueObject].self, from:data) {
                            
                            if let searchResults = Search.searchResultsWith(searchKeyword: self.searchKeyword, issues: issues, inManagedObjectContext: self.context), let issues = searchResults.issues{
                                
                                try? self.context.save()
                               
                                let issueArray = Array(issues) as! [Issue]
                                self.navigateToIssuesController(withIssues: issueArray)
                            }
                            
                        } else {
                            
                            self.showAlert(withErrorMessage: "Error parsing object")
                        }
                    }
                    
                default:
                    
                    if let error = response.error {
                        self.showAlert(withErrorMessage: error.localizedDescription)
                    } else {
                        self.showAlert(withErrorMessage: "Error Fetching Data")
                    }
                }
            }
        }

    }
    
    func navigateToIssuesController(withIssues issues: [Issue]) {
        
        let issueController = self.storyboard?.instantiateViewController(withIdentifier: IssuesViewController.identifier) as! IssuesViewController
        issueController.issues = issues
        
        self.navigationController?.pushViewController(issueController, animated: true)
        
    }
}


