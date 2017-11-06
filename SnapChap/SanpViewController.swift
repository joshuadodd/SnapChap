//
//  SanpViewController.swift
//  SnapChap
//
//  Created by joshua dodd on 10/27/17.
//  Copyright © 2017 Codebase. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
    
    
    @IBOutlet weak var snapViewImage: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    var timer: Timer!
    var counter = 1
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapViewImage.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onTimer()
    }
   
    
    func onTimer() {
        self.counterLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:{_ in
            self.counter -= 1
            self.counterLabel.text = "\(self.counter)"
            print(self.counter)
            if self.counter == 0 {
                self.performSegue(withIdentifier: "UnwindSnap", sender: nil)
                self.timer.invalidate()
            }
            
            
        })
    }
}
