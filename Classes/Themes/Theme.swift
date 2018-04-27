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
    var backgroundColor : UIColor!
    var selectedBackgroundColor : UIColor!
    var photoBackgroundcolor : UIColor!
    var fontName : String!
    var statusBarStyle : UIStatusBarStyle!
    var navigationBarStyle : UIBarStyle!
    var tabBarTintColor : UIColor!
    var tabBarStyle : UIBarStyle!
    
    required init() {
    }
    
    static func named(_ name : String) -> Theme {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        let cls = NSClassFromString("\(namespace).\(name)Theme") as! Theme.Type
        return cls.init()
    }
    
    // Apply the theme.
    func apply() {
        self.setAppearance()
        self.redraw()
    }
    
    // Set all the appearance options.
    private func setAppearance() {
        
        // Set default background colors.
        TemplateView.appearance().backgroundColor = self.backgroundColor
        PhotoBackgroundView.appearance().backgroundColor = self.photoBackgroundcolor
        UITableView.appearance().backgroundColor = self.backgroundColor
        UITableViewCell.appearance().backgroundColor = self.backgroundColor
        
        // Set bakgrond of selected table cells.
        // set up your background color view
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
        
        // Set appearance for buttons.
        UILabel.appearance(whenContainedInInstancesOf: [UIButton.self]).font = UIFont(name: self.fontName, size: 17.0)
        UIButton.appearance().setTitleColor(self.buttonColor, for:.normal)
        
        // Set appearance for tab bar items.
        UITabBar.appearance().tintColor = self.tabBarTintColor
        UITabBar.appearance().barTintColor = self.backgroundColor
        UITabBar.appearance().barStyle = self.tabBarStyle
        
        // Set appearance for collection views.
        UICollectionView.appearance().backgroundColor = self.backgroundColor
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
        
    }

}
