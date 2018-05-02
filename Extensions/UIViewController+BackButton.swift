//
//  UIViewController+BackButton.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// This extension allows all view controllers to be configured with the custom BackButton when pushed to a navigation controller.
// See the BackButton class for details.

import UIKit

extension UIViewController {
    
    func setCustomBackButton() {
        // Create a custom back button.
        let customBackButton = Bundle.main.loadNibNamed("BackButton", owner: self, options: nil)![0] as! BackButton
        customBackButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        // Get the name of the previous controller.
        var title : String
        if let navController = self.navigationController, navController.viewControllers.count >= 2 {
            title = navController.viewControllers[navController.viewControllers.count - 2].title!
        } else {
            title = "Back"
        }
        customBackButton.setTitle(title, for: .normal)
        
        // Ensure the back button can be tapped.
        customBackButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: customBackButton)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
