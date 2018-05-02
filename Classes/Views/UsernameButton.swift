//
//  UsernameButton.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class UsernameButton : UIButton {
    
    var customSetup : Bool! = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (!customSetup) {
            customSetup = true
            
            self.titleLabel?.font = Theme.current!.usernameButtonFont()
            
            // Listen for theme changes
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateForTheme), name: .themeWasApplied, object: nil)
        }
    }
    
    // Force background to update in respose to theme change.
    @objc func updateForTheme(notification : Notification) {
        let theme = notification.userInfo!["theme"] as! Theme
        self.titleLabel?.font = theme.usernameButtonFont()
    }
    
}
