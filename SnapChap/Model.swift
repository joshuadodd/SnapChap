//
//  Model.swift
//  SnapChap
//
//  Created by joshua dodd on 10/30/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit


struct Snap {
    let author: String
    let time: Date
    let imageUri: String
    let seen: [String:Bool]
    var imageData: Data?
    var name: String?
    
    var asDictionary: [String: Any] {
        return [
            "author": author,
            "time": time.timeIntervalSinceReferenceDate,
            "imageURI": imageUri,
            "seen": seen
            
        ]
    }
    var image: UIImage? {
        if let imageData = imageData {
            return UIImage(data: imageData)
        }
        return nil
    }
}

extension Snap {
    
    init? (from rawSnap: [String: Any]) {
        
        guard let author = rawSnap["author"] as? String,
            let time = rawSnap["time"] as? TimeInterval,
            let seen = rawSnap["seen"] as? [String:Bool],
            let imageUri = rawSnap["imageUri"] as? String else { return nil }
        
        self.author = author
        self.time = Date(timeIntervalSinceReferenceDate: time)
        self.imageUri = imageUri
        self.seen = seen
    }
}

struct Chap {
    let name: String?
    let profileImageUri: String?
    let friends: [String]
    
    var asDictionary: [String: Any] {
        return [
            "name": name,
            "friends": friends,
            "profileImageUri": profileImageUri
        ]
    }
}

extension Chap {
    
    init? (from rawChap: [String: Any]) {
        
        name = rawChap["name"] as? String
        profileImageUri = rawChap["profileImageUri"] as? String
        if let f = rawChap["friends"] as? [String] {
            friends = f
        }else{
            friends = []
        }
        
        
        
    }
}
