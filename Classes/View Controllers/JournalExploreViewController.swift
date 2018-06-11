//
//  JournalExploreViewController.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// This class allows all subclasses to be configured with the close button when pushed to a navigation controller.

import UIKit

class JournalExploreViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
        self.setCustomCloseButton()
    }
    
    func setCustomCloseButton() {
      
        let customButton = UIButton(type: .custom)
        customButton.titleLabel?.font = UIFont.init(name: "FontAwesome5FreeSolid", size: 14)
        customButton.setTitle("", for: .normal)
        customButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        customButton.addTarget(self, action: #selector(self.closeButtonPressed), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customButton)
    }
    
    @objc func closeButtonPressed() {
        if ((self.navigationController?.presentingViewController) != nil) {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
