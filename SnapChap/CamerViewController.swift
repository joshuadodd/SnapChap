//
//  FirstViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit
import Firebase


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var chapNames: [String] = []
    var snapImageSelected: UIImage?
    
    @IBOutlet weak var snapChapImageViewOutlet: UIImageView!
    
    @IBOutlet weak var onShareButton: UIButton!
    
    @IBOutlet weak var onCancelButton: UIButton!
    
    @IBOutlet weak var snapAchapButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onCancelButton.isHidden = true
        onShareButton.isHidden = true
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("chaps").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value as? [String: Any] else { return }
                let chap = Chap(from: value)
                
                for friend in (chap?.friends)! {
                    let ref = Database.database().reference().child("chaps").child(friend).child("name")
                    ref.observe(.value, with: { (snapshot) in
                        guard let value = snapshot.value as? String else { return }
                        self.chapNames.append(value)
                        
                    })
                }
                
            })
        }
        
    }
    
    @IBAction func snapAchapButtonPressed(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .savedPhotosAlbum
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func unwindFromShareVC(segue: UIStoryboardSegue) {
        snapChapImageViewOutlet.image = nil
        snapAchapButton.isHidden = false
        onCancelButton.isHidden = true
        onShareButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.friendsList = chapNames
        shareVC?.snapImage = snapImageSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            snapChapImageViewOutlet.image = image
            snapImageSelected = image
        }
        picker.dismiss(animated: true)
        onCancelButton.isHidden = false
        onShareButton.isHidden = false
        snapAchapButton.isHidden = true
    }
    
    @IBAction func onSharePressed(_ sender: Any) {
        
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        snapChapImageViewOutlet.image = nil
        snapAchapButton.isHidden = false
        onCancelButton.isHidden = true
        onShareButton.isHidden = true
    }
    
}
