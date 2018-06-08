//
//  EntryNavigationTitleView.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// A class used in the Entry controller's navigation title.

import UIKit

class EntryNavigationTitleView : UIView {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var dateLabel : UILabel!
    @IBOutlet var usernameButton : UIButton!
    
    override var intrinsicContentSize: CGSize {
        let width = max(titleLabel.frame.size.width, usernameButton.frame.size.width + usernameButton.contentEdgeInsets.left + usernameButton.contentEdgeInsets.right)
        return CGSize(width: width, height: 44)
    }
    
    func configure(title : String, date : String, username : String) {
        
        let currentTheme = Theme.current!
        
        titleLabel.text = title
        titleLabel.font = UIFont.init(name: (currentTheme.fontName)!, size: 15)
        titleLabel.sizeToFit()
        
        dateLabel.text = date
        dateLabel.font = UIFont.init(name: (currentTheme.fontName)!, size: 12)
        
        usernameButton.setTitle(username, for: .normal)
        usernameButton.setTitleColor(currentTheme.textColor, for: .normal)
        usernameButton.titleLabel?.font = UIFont.init(name: (currentTheme.fontName)!, size: 15)
        usernameButton.sizeToFit()
        
        self.invalidateIntrinsicContentSize()
    }
    
}
