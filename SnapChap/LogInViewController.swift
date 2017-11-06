//
//  LogInViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var onLoginButtonPressed: UIButton!
    
    @IBOutlet weak var onEmailTextField: UITextField!
    
    @IBOutlet weak var onPasswordTextField: UITextField!
    
    @IBOutlet weak var onPasswordConfirmTextField: UITextField!
    
    @IBOutlet weak var onLoginConfirmTextField: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        
    }
    
    
    @IBAction func loginSignUpSegmentChanged(_ sender:  UISegmentedControl) {
        switch onLoginConfirmTextField.selectedSegmentIndex {
            
        case 0: onPasswordConfirmTextField.isHidden = true
        onLoginButtonPressed.setTitle("Login", for: .normal)
            
        case 1: onLoginButtonPressed.setTitle("Sign up", for: .normal)
        onPasswordConfirmTextField.isHidden = false
            
            
        default:
            break
        }
    }
    @IBAction func onLoginPressed(_sender: UIButton){
        if onEmailTextField.text != nil, onPasswordTextField.text != nil {
            if onLoginConfirmTextField.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: onEmailTextField.text!, password:onPasswordTextField.text!, completion: { (user, error) in
                    print(error)
                    NotificationCenter.default.post(name: logMeInNotificationName, object: nil)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                })
            }else{//user is signing up
                if onPasswordConfirmTextField.text == onPasswordConfirmTextField.text {
                    Auth.auth().createUser(withEmail: onEmailTextField.text!, password: onPasswordConfirmTextField.text!) { (user, error) in
                        print(error)
                        
                        NotificationCenter.default.post(name: logMeInNotificationName, object: nil)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    }
                }
            }
        }
    }
    
}


