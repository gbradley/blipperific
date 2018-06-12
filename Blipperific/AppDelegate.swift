//
//  AppDelegate.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var theme: Theme!
    var tabBarController : UITabBarController!
    
    var errorMessageView : ErrorMessageView!
    var errorMessageHeight : CGFloat!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Load up the tab bar from the XIB, which means we can use the appearance proxy on its tab bar and the bar items.
        self.tabBarController = Bundle.main.loadNibNamed("TabBar", owner: self, options: nil)![0] as! UITabBarController
        self.tabBarController.delegate = self
        
        self.loadBrowseTab(self.tabBarController.viewControllers![0] as! UINavigationController)
        self.loadSettingsTab(self.tabBarController.viewControllers![1] as! UINavigationController)
            
        window!.rootViewController = self.tabBarController
        window!.makeKeyAndVisible()
        
        // Set the inital theme.
        self.switchTheme("White")
        
        /*UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })*/
        return true
    }
    
    func displayErrorMessage(message : String) {

        if (errorMessageView == nil) {
            let window = UIApplication.shared.keyWindow!
            let subview = window.subviews.first!
            
            let rect = message.boundingRect(with: CGSize(width: subview.frame.size.width - 20, height: 10000), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: [NSAttributedStringKey.font : UILabel.appearance().font], context: nil)
            errorMessageHeight = ceil(rect.size.height) + 20
            
            errorMessageView = Bundle.main.loadNibNamed("ErrorMessageView", owner: self, options: nil)![0] as! ErrorMessageView
            errorMessageView.messageLabel.text = message
            errorMessageView.frame = CGRect(x: 0, y: subview.frame.size.height, width: 320, height: errorMessageHeight)
            window.addSubview(errorMessageView)
            
            UIView.animate(withDuration: 0.3) {
                self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: -self.errorMessageHeight)
                
                var frame = subview.frame
                frame.size.height = frame.size.height - self.errorMessageHeight
                subview.frame = frame
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.removeErrorMessage()
            }
        }
    }
    
    func removeErrorMessage() {
        
        let window = UIApplication.shared.keyWindow!
        let subview = window.subviews.first!
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: self.errorMessageHeight)
            subview.frame = UIScreen.main.bounds
            
        }) { (complete) in
            
            self.errorMessageView.removeFromSuperview()
            self.errorMessageView = nil
            
        }
        
        
    }
    
    // Load the brose tab into its nav controller.
    private func loadBrowseTab(_ navigationController : UINavigationController) {
        let browseViewController = BrowseViewController(nibName: "BrowseView", bundle: nil)
        browseViewController.title = "Browse"
        navigationController.viewControllers = [browseViewController]
    }
    
    // Load the settings tab into its nav controller.
    private func loadSettingsTab(_ navigationController : UINavigationController) {
        let settingsViewController = SettingsViewController(nibName: "SettingsView", bundle: nil)
        settingsViewController.title = "Settings"
        navigationController.viewControllers = [settingsViewController]
    }
    
    // Switch to the named theme.
    func switchTheme(_ name : String) {
        
        let theme = Theme.named(name)
        theme.apply()
        
        /* Used when not inside a nav controller, can remove otherwise.
        if let controller =  self.tabBarController {
            controller.setNeedsStatusBarAppearanceUpdate()
        }*/
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Return an environment variable from the xcconfig file.
    func env(_ key: String) -> String {
        return ((Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: ""))!
    }
}

