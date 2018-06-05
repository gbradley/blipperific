//
//  BackButton.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// This class exists to allow us to consistently style the back button in response to theme changes.
// - The default back button won't honour redrawing font appearance() because its label is not created through IB, and in this case .backBarButtonItem property is always nil
// - Ideally we'd set a UIView subclass (which would be themeable) to the UIBarButtonItem via init(customView:), but there's an iOS 11 issue where custom views don't respond to gestures.
// - So instead we subclass UIButton and make it listen to `themeWasApplied` notifications in order to force the label's font to update.

import UIKit

class BackButton : UIButton {
    
    var customSetup : Bool! = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (!customSetup) {
            customSetup = true
            
            self.titleLabel?.font = Theme.current!.backButtonFont()
            
            // Listen for theme changes
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateForTheme), name: .themeWasApplied, object: nil)
        }
    }
    
    // Force background to update in respose to theme change.
    @objc func updateForTheme(notification : Notification) {
        let theme = notification.userInfo!["theme"] as! Theme
        self.titleLabel?.font = theme.backButtonFont()
    }
    
}
