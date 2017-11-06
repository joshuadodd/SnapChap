//
//  SecondViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import Firebase

class FriendsViewController: UITableViewController {
    
    var snaps: [Snap] = []
    let snap = UIImage.self
    var chapNames: [String] = []
    var friends: [String] = []
    var chap: Chap?
    
    @IBAction func unwindFromCommentingVC(segue: UIStoryboardSegue) {
        //let snapVC = segue.source as! SnapViewController
    }
    
    @IBAction func unwindFromSnapVC(segue: UIStoryboardSegue) {
        //let snapVC = segue.source as! SnapViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("chaps").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value as? [String: Any] else { return }
                let chap = Chap(from: value)
                self.chap = chap
                
                
                
                for friend in (chap?.friends)! {
                    let ref = Database.database().reference().child("chaps").child(friend).child("name")
                    ref.observe(.value, with: { (snapshot) in
                        guard let value = snapshot.value as? String else { return }
                        self.chapNames.append(value)
                        self.tableView.reloadData()
                    })
                }
                
            })
        }
        //                                for friend in self.friends {
        //                                    let ref = Database.database().reference().child("snaps").queryOrdered(byChild: "author").queryEqual(toValue: friend )
        //                                    ref.observe(.childAdded, with: { (snapshot) in
        //
        //                                        guard let rawSnap = snapshot.value as? [String: Any] else {
        //                                            return
        //                                        }
        //                                        guard var snap = Snap(from: rawSnap)
        //                                            else{
        //                                                return
        //                                        }
        //                                        //self.snap =  rawSnap.values.flatMap(Snap.init)
        //
        //                                        if snap.imageUri.hasPrefix("gs://") {
        //                                            let url = snap.imageUri
        //                                            let ref = Storage.storage().reference(forURL: url)
        //                                            ref.getData(maxSize: Int64.max) { (data, error) in
        //                                                snap.imageData = data
        //                                                self.snaps.insert(snap, at: 0)
        //                                                let ref = Database.database().reference().child("chaps").child(snap.author).child("name")
        //                                                ref.observe(.value, with: { (snapshot) in
        //                                                    guard let value = snapshot.value as? String else { return }
        //                                                    snap.name = value
        //                                                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        //                                                    self.tableView.reloadData()
        //
        //                                                })
        //                                            }
        //                                        }
        //                                    })
        //                                }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapNames.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendNameCell", for: indexPath)
        //        cell.snapImageView.image = snaps[indexPath.row].image
        //        cell.friendSnapLabel.text = snaps[indexPath.row].name
        
        cell.textLabel?.text = chapNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ref = Database.database().reference().child("snaps").queryOrdered(byChild: "author").queryEqual(toValue: (chap?.friends[indexPath.row])!)
        ref.observe(.childAdded, with: { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            if let snap = Snap(from: value) {
                if snap.imageUri.hasPrefix("gs://") {
                    
                    var downloadedSnaps = [Snap]()
                    downloadedSnaps.append(snap)
                    downloadedSnaps.sort(by: {$0.time.compare($1.time) == .orderedAscending})
                    for snap in downloadedSnaps {
                        let ref = Storage.storage().reference(forURL: snap.imageUri)
                        ref.getData(maxSize: Int64.max) { (data, error) in
                            if let data = data, let image = UIImage(data: data){
                                self.performSegue(withIdentifier: "ViewSnapSegue", sender: image)
                            }
                        }
                    }
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let snapVC = segue.destination as? SnapViewController, let image = sender as? UIImage {
            snapVC.image = image
        }
    }
    
}


class FriendCell: UITableViewCell {
    
    @IBOutlet weak var snapImageView: UIImageView!
    
    @IBOutlet weak var friendSnapLabel: UILabel!
    
}

class FriendNameCell: UITableViewCell {
    
}


