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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Load up the tab bar from the XIB, which means we can use the appearance proxy on its tab bar and the bar items.
        self.tabBarController = Bundle.main.loadNibNamed("TabBar", owner: self, options: nil)![0] as? UITabBarController
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

