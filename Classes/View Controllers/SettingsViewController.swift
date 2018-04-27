//
//  SettingsViewController.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var whiteTheme : UIButton!
    @IBOutlet var retroTheme : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeThemePressed(_ sender : UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchTheme(sender == self.whiteTheme ? "White" : "Retro")
    }
}

