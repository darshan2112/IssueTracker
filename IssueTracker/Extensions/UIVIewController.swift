//
//  UIVIewController.swift
//  IssueTracker
//
//  Created by Darshan K S on 27/10/18.
//  Copyright © 2018 IssueTracker. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withErrorMessage error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
