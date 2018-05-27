//
//  EntryViewController.swift
//  Blipperific
//
//  Created by Graham on 08/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryViewController : JournalViewController, UITableViewDelegate, UITableViewDataSource, EntryMainTableViewCellDelegate {
    
    @IBOutlet var entryTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tractor Factory Photos"
        self.setCustomNavigationTitle()
        
        self.entryTableView.register(UINib(nibName: "EntryMainTableViewCell", bundle:nil), forCellReuseIdentifier: "EntryMainTableViewCell")
    }
    
    // Create a custom view to replace the default navigation title.
    func setCustomNavigationTitle() {
    
        let entryNavigationTitleView = Bundle.main.loadNibNamed("EntryNavigationTitleView", owner: self, options: nil)![0] as! EntryNavigationTitleView
        entryNavigationTitleView.titleLabel.text = self.title
        entryNavigationTitleView.titleLabel.font = UIFont.init(name: (Theme.current?.fontName)!, size: 15)
        
        entryNavigationTitleView.dateLabel.text = "3rd March, 2018"
        entryNavigationTitleView.dateLabel.font = UIFont.init(name: (Theme.current?.fontName)!, size: 12)
        self.navigationItem.titleView = entryNavigationTitleView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cell .isKind(of: EntryMainTableViewCell.self)) {
            (cell as! EntryMainTableViewCell).prepareForDisplay()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryMainTableViewCell", for: indexPath) as! EntryMainTableViewCell
        cell.delegate = self

        return cell
    }
    
    // ! EntryMainTableViewCellDelegate
    
    func entryMainTableViewCell(_ cell: EntryMainTableViewCell, didScrollTo xRatio: CGFloat) {

        let entryNavigationTitleView = self.navigationItem.titleView as! EntryNavigationTitleView
        entryNavigationTitleView.dateLabel.alpha = 1 - abs(xRatio)
        
        self.entryTableView.transform = CGAffineTransform(translationX: 20 * xRatio, y: 0)
    }
}
