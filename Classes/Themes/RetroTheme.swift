//
//  RetroTheme.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class RetroTheme : Theme {
    
    required init() {
        super.init()
        self.headingColor = UIColor.init(rgb: 0xFFFFFF)
        self.textColor = UIColor.init(rgb: 0xcbcbcb)
        self.buttonColor = UIColor.init(rgb: 0xebdfac)
        self.usernameButtonColor = UIColor.init(rgb: 0xc2c2c2)
        self.backgroundColor = UIColor.init(rgb: 0x404040)
        self.selectedBackgroundColor = UIColor.init(rgb: 0x3a3a3a)
        self.photoBackgroundColor = UIColor.init(rgb: 0x555555)
        self.fontName = "Georgia"
        self.userTextFontName = "Georgia"
        self.userBoldTextFontName = "Georgia-Bold"
        self.userItalicTextFontName = "Georgia-Italic"
        self.userTextLineSpacing = 5
        self.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationBarStyle = UIBarStyle.blackTranslucent
        self.tabBarTintColor = UIColor.init(rgb : 0xFFFFFF)
        self.tabBarStyle = UIBarStyle.black
    }
    
}
