//
//  TabBarViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/30/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import FirebaseAuth

let logMeInNotificationName = Notification.Name("LogMeInDidCompleteNotification")

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(forName: logMeInNotificationName, object: nil, queue: .main) { _ in
            if let loginVC = self.presentedViewController as? LogInViewController {
                loginVC.dismiss (animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginVC, animated: animated)
            
            
        }else {
            NotificationCenter.default.post(name: logMeInNotificationName, object: nil)
        }
    }
}
