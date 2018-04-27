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
        self.backgroundColor = UIColor.init(rgb: 0x404040)
        self.selectedBackgroundColor = UIColor.init(rgb: 0x3a3a3a)
        self.photoBackgroundcolor = UIColor.init(rgb: 0x555555)
        self.fontName = "Georgia"
        self.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationBarStyle = UIBarStyle.blackTranslucent
        self.tabBarTintColor = UIColor.init(rgb : 0xFFFFFF)
        self.tabBarStyle = UIBarStyle.black
    }
    
}
