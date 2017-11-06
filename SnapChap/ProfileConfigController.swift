//
//  ProfileConfigController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import FirebaseAuth
class ProfileConfigController: UITableViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var profilePictureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
//    func getUserInfo() {
//        let ref = Database.database().reference().child("snaps")
//        ref.observeSingleEvent(of: .value) { (snapshot) in
//            guard let rawSnaps = snapshot.value as? [[String: Any]] else { return }
//
//            //            var temp: [Snap] = []
//            //            for rawSnap in rawSnaps {
//            //                if let snap = Snap(from: rawSnap) {
//            //                    temp.append(snap)
//            //                }
//            //
//            //            }
//            //            self.snaps = temp
//
//            self.snaps =  rawSnaps.flatMap(Snap.init)
//            self.tableView.reloadData()
//        }
//
//    }
//    }
    
    //    @IBAction func unwindFromCProfileConfigVC(segue: UIStoryboardSegue) {
    //        let snapVC = segue.source as! TabBarViewController
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try  Auth.auth().signOut()
            performSegue(withIdentifier: "Logout", sender: self)
        }catch{
            print("Error signing out")
        }
    }
    
}



