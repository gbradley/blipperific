//
//  Theme.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class Theme {
    
    var headingColor : UIColor!
    var textColor : UIColor!
    var buttonColor : UIColor!
    var usernameButtonColor : UIColor!
    var backgroundColor : UIColor!
    var selectedBackgroundColor : UIColor!
    var photoBackgroundColor : UIColor!
    var fontName : String!
    var userTextFontName : String!
    var userBoldTextFontName : String!
    var userItalicTextFontName : String!
    var userTextLineSpacing : CGFloat!
    var statusBarStyle : UIStatusBarStyle!
    var navigationBarStyle : UIBarStyle!
    var tabBarTintColor : UIColor!
    var tabBarStyle : UIBarStyle!
    
    static var current : Theme?
    
    required init() {
    }
    
    static func named(_ name : String) -> Theme {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        let cls = NSClassFromString("\(namespace).\(name)Theme") as! Theme.Type
        return cls.init()
    }
    
    // Apply the theme.
    func apply() {
        Theme.current = self
        self.setAppearance()
        self.redraw()
    }
    
    // Set all the appearance options.
    private func setAppearance() {
        
        // Set default background colors.
        TemplateView.appearance().backgroundColor = self.backgroundColor
        UITableView.appearance().backgroundColor = self.backgroundColor
        UITableViewCell.appearance().backgroundColor = self.backgroundColor
        PhotoBackgroundView.appearance().backgroundColor = self.photoBackgroundColor
        DisclosureButton.appearance().tintColor = self.buttonColor
        
        // Set backgrond of selected table cells.
        let backgroundView = UIView()
        backgroundView.backgroundColor = self.selectedBackgroundColor
        UITableViewCell.appearance().selectedBackgroundView = backgroundView
        
        // Set appearance for headings.
        let headingLabelAppearance = HeadingLabel.appearance()
        headingLabelAppearance.textColor = self.headingColor
        headingLabelAppearance.font = UIFont(name: self.fontName, size: 18.0)
        
        // Set appearance for titles.
        let titleLabelAppearance = TitleLabel.appearance()
        titleLabelAppearance.textColor = self.headingColor
        titleLabelAppearance.font = UIFont(name: self.fontName, size: 15.0)
        
        // Set appearance for nagivation bar.
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: self.headingColor,
            NSAttributedStringKey.font: UIFont(name: self.fontName, size: 24)!
        ]
        navigationBarAppearance.barStyle = self.navigationBarStyle
        navigationBarAppearance.barTintColor = self.backgroundColor
        
        // Set appearance for bar buttons.
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.tintColor = self.buttonColor
        for controlState in [UIControlState.normal, UIControlState.disabled, UIControlState.focused, UIControlState.highlighted, UIControlState.selected] {
            barButtonItemAppearance.setTitleTextAttributes([
                NSAttributedStringKey.foregroundColor: self.buttonColor,
                NSAttributedStringKey.font: UIFont(name: self.fontName, size: 15)!
                ], for: controlState)
        }
        
        // Set appearance for labels.
        let labelAppearance = UILabel.appearance()
        labelAppearance.textColor = self.textColor
        labelAppearance.font = UIFont(name: self.fontName, size: 14.0)
        StatisticLabel.appearance().font = UIFont(name: self.fontName, size: 12.0)
        
        // Set appearance for text views.
        UITextView.appearance().tintColor = self.buttonColor
        
        // Set appearance for buttons.
        UILabel.appearance(whenContainedInInstancesOf: [UIButton.self]).font = self.buttonFont()
        UIButton.appearance().setTitleColor(self.buttonColor, for:.normal)
        UIButton.appearance().setTitleColor(self.textColor, for:.disabled)
        UIButton.appearance().tintColor = self.buttonColor
        
        UILabel.appearance(whenContainedInInstancesOf: [UsernameButton.self]).font = self.usernameButtonFont()
        UsernameButton.appearance().setTitleColor(self.usernameButtonColor, for:.normal)
        UsernameButton.appearance().setTitleColor(self.buttonColor, for:.highlighted)
        
        StatisticButton.appearance().setTitleColor(self.textColor, for:.normal)
        StatisticButton.appearance().setTitleColor(self.buttonColor, for: .highlighted)
        StatisticButton.appearance().setTitleColor(self.buttonColor, for: .selected)
        StatisticButton.appearance().setTitleColor(self.buttonColor, for: [.highlighted, .selected])
        
        SecondaryButton.appearance().setTitleColor(self.textColor, for:.normal)
        SecondaryButton.appearance().setTitleColor(self.buttonColor, for: .highlighted)
        SecondaryButton.appearance().setTitleColor(self.buttonColor, for: .selected)
        SecondaryButton.appearance().setTitleColor(self.buttonColor, for: [.highlighted, .selected])
        
        // Set appearance for tab bar items.
        UITabBar.appearance().tintColor = self.tabBarTintColor
        UITabBar.appearance().barTintColor = self.backgroundColor
        UITabBar.appearance().barStyle = self.tabBarStyle
        
        // Set appearance for collection views.
        UICollectionView.appearance().backgroundColor = self.backgroundColor
        
        // Set appearance for refresh / activity controls.
        UIRefreshControl.appearance().tintColor = self.buttonColor
        UIActivityIndicatorView.appearance().color = self.buttonColor
    }
    
    /* Expose methods that are needed by components when having to update themselves. */
    
    func buttonFont() -> UIFont {
        return UIFont(name: self.fontName, size: 17.0)!
    }
    
    func backButtonFont() -> UIFont {
        return UIFont(name: self.fontName, size: 14.0)!
    }
    
    func usernameButtonFont() -> UIFont {
        return UIFont(name: self.fontName, size: 12.0)!
    }
    
    // Force the app to redraw using the most recent appearance.
    private func redraw() {
        
        let windows = UIApplication.shared.windows
        for window in windows {
            
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
        
        NotificationCenter.default.post(name: .themeWasApplied, object: nil, userInfo: ["theme" : self])
    }

}
