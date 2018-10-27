//
//  IssuesViewController.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//

import UIKit

class IssuesViewController: UIViewController {

    static let identifier = "IssuesViewController"
    
    var issues: [Issue]?
    
    @IBOutlet weak var issuesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.issuesTableView.estimatedRowHeight = 100.0
        self.issuesTableView.rowHeight = 100.0
        self.issuesTableView.register(UINib(nibName: IssuesTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: IssuesTableViewCell.identifier)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IssuesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let issues = self.issues {
            
            return issues.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IssuesTableViewCell.identifier) as! IssuesTableViewCell
        
        if let issue = self.issues?[indexPath.row] {
            
            cell.PRNumberLabel.text = issue.number!
            
            if let title = issue.title{
                 cell.titleLabel.text = title
            }
            
            if let user = issue.user?.userName {
                 cell.userLabel.text = user
            }
            
            if let patch = issue.patchUrl {
                cell.patchLabel.text = patch
            }
           
        }
        
        return cell
    }
    
}


extension IssuesViewController: UITableViewDelegate {
    
    
}
