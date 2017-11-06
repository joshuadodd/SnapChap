//
//  AppDelegate.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Firebase.Database.database().isPersistenceEnabled = true
        
        // THIS CODE IS A TEMPORARY HACK
        if let uid = Auth.auth().currentUser?.uid {
            let me: [String: Any] = [
                "name": "joshuadodd", //your username goes here
                "friends": [
                    "0": "DH7GnqNeVbeCznXD52QmoV2abQq1", //the `uid` of someone you want to add
                    "1": "U4hhRLktgsWCcBLenRuByGuP8Hm2",
                    "2": "m9jrcKwCbackVh1sb3EiJjFna2q2",
                    "3": "BfhHZkn2n5g8RrBsxC7vrGNldef2",
                    "4": "Iv9lGkiAqgamavTV1rbk8IzU0l43"
                ]
            ]
            Database.database().reference().child("chaps").child(uid).updateChildValues(me) { (error, ref) in
                print(error, ref)
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

