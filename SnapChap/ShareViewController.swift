//
//  ShareViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 11/3/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import Firebase

class ShareViewController: UITableViewController {
    
    var snapImage: UIImage!
    var selectedFriends: [String] = []
    var friendIds: [String] = []
    var friendsList: [String] = []
    var friendId: String?
    
    
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        upload(snapImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func upload(_ image: UIImage) {
        if let userId = Auth.auth().currentUser?.uid {
            let snapDate = Date()
            let ref = Storage.storage().reference().child(userId).child("\(snapDate.timeIntervalSinceReferenceDate).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            ref.putData(imageData!, metadata: metadata, completion: { (metadata, error) in
                if let metadata = metadata, let path = metadata.path {
                    let imageUri = "gs://\(metadata.bucket)/\(path)"
                    let selectedRows = self.tableView.indexPathsForSelectedRows
                    var seen: [String:Bool] = ["":false]
                    
                    for indexPath in selectedRows! {
                        seen[self.friendIds[indexPath.row]] = false
                    }
                    if let userId = Auth.auth().currentUser?.uid {
                        let snap = Snap(author: userId, time: snapDate, imageUri: imageUri, seen: [userId:false], imageData: nil, name: nil)
                        self.create(snap)
                        print(self.selectedFriends)
                    }
                }
            })
            
        }
        
    }
    
    func create(_ snap: Snap){
        let ref = Database.database().reference().child("snaps").childByAutoId()
        ref.updateChildValues(snap.asDictionary) { (error, ref) in
            //print(error, ref)
            self.performSegue(withIdentifier: "ShareVCUnwind", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedFriends", for: indexPath)
        cell.textLabel?.text = friendsList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
    }
}


