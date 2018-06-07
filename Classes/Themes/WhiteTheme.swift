//
//  WhiteTheme.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class WhiteTheme : Theme {
    
    required init() {
        super.init()
        self.headingColor = UIColor.init(rgb: 0x444444)
        self.textColor = UIColor.init(rgb: 0x595959)
        self.buttonColor = UIColor.init(rgb: 0x1897D2)
        self.usernameButtonColor = UIColor.init(rgb: 0x484848)
        self.backgroundColor = UIColor.init(rgb: 0xFFFFFF)
        self.selectedBackgroundColor = UIColor.init(rgb: 0xededed)
        self.photoBackgroundColor = UIColor.init(rgb: 0xf6f6f6)
        self.fontName = "Museo-500"
        self.userTextFontName = "Roboto-Regular"
        self.userBoldTextFontName = "Roboto-Bold"
        self.userItalicTextFontName = "Roboto-Italic"
        self.userTextLineSpacing = 3
        self.statusBarStyle = UIStatusBarStyle.default
        self.navigationBarStyle = UIBarStyle.default
        self.tabBarTintColor = UIColor.init(rgb : 0x1897D2)
        self.tabBarStyle = UIBarStyle.default
    }
    
}
