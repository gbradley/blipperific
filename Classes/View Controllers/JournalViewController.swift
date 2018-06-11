//
//  JournalViewController.swift
//  Blipperific
//
//  Created by Graham on 11/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class JournalViewController: JournalExploreViewController, UIScrollViewDelegate, EntryViewControllerDelegate {
    
    @IBOutlet var journalBar : UIView!
    @IBOutlet var journalUsernameButton : UsernameButton!
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var scrollContentView : UIView!
    
    @IBOutlet var leftContainer : UIView!
    @IBOutlet var middleContainer : UIView!
    @IBOutlet var rightContainer : UIView!
    
    enum EntryCursor : Int {
        case Previous = 0
        case Current = 1
        case Next = 2
    }
    
    // Create a dictionary to map entry view controllers to their cursors.
    var entryViewControllers : [EntryCursor:EntryViewController] = [:]
    
    // Stores references to journal bar height contstraint and initial value.
    var journalBarHeightConstraint : NSLayoutConstraint!
    var journalBarHeight : CGFloat!
    var entryNavigationTitleBarHeight : NSLayoutConstraint!
    
    // Create a dictionary to map entry IDs to their cursors.
    var ids : [EntryCursor : Int] = [.Previous : 0, .Current : 0, .Next : 0]
    
    convenience init(id : Int, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Listen for entry updates.
        NotificationCenter.default.addObserver(self, selector: #selector(self.entryRecordUpdated), name: .entryManagerDidUpdateRecord, object: nil)
        
        // Set the middle ID.
        self.ids[.Current] = id
        
        // Set the prev / next IDs if they exist.
        self.ids[.Previous] = 2437276593656172459
        
        // Request a record update.
        _ = EntryManager.shared.updateRecord(for: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTitles()
        self.registerConstraints()
        
        self.configureEntryViewControllerAt(cursor : .Current)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the initial content size & offset of the scroller.
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height - journalBarHeight)
        self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureEntryViewControllerAt(cursor : .Previous)
        self.configureEntryViewControllerAt(cursor : .Next)
    }
    
    // Return the record for the entry at the given cursor.
    func recordFor(cursor : EntryCursor) -> EntryRecord? {
        var record : EntryRecord?
        let id = ids[cursor]!
        if (id > 0) {
            record = EntryManager.shared.record(for: id)
        }
        return record
    }
    
    // Configure the navigation tiles and buttons based on the stored response.
    func configureTitles() {
        
        var username : String = ""
        var journalTitle : String = ""
        var dateStr : String = ""
        
        if let record = self.recordFor(cursor: .Current) {
            if let response = record.response {
                username = response.entry.username
                dateStr = String(response.entry.date_stamp)
                
                if let details = response.details {
                    journalTitle = details.journal_title
                }
            }
        }
        
        // Configure the title.
        self.title = username
        self.setCustomNavigation(title: journalTitle, dateStr: dateStr, username: username)
        
        // Configure the journal bar.
        self.journalUsernameButton.setTitle(username == "" ? "" : "by " + username, for: .normal)
        self.journalUsernameButton.sizeToFit()
    }
    
    func registerConstraints() {
        // Obtain reference to journal bar height constraint and the initial value.
        var filteredConstraints = journalBar.constraints.filter { $0.identifier == "EntryJournalBarHeight" }
        if let constraint = filteredConstraints.first {
            journalBarHeightConstraint = constraint
            journalBarHeight = constraint.constant
        }
        
        // Do the same for entry navigation bar height constraint.
        let navigationBar = self.navigationItem.titleView as! EntryNavigationTitleView
        filteredConstraints = navigationBar.subviews[0].constraints.filter { $0.identifier == "EntryNavigationTitleBarHeight" }
        if let constraint = filteredConstraints.first {
            entryNavigationTitleBarHeight = constraint
        }
    }
    
    // Create a custom view to replace the default navigation title.
    func setCustomNavigation(title : String, dateStr : String, username : String) {
        if (self.navigationItem.titleView == nil) {
            self.navigationItem.titleView = Bundle.main.loadNibNamed("EntryNavigationTitleView", owner: self, options: nil)![0] as! EntryNavigationTitleView
        }
        (self.navigationItem.titleView as! EntryNavigationTitleView).configure(title: title, date: dateStr, username: username)
    }
    
    // Entry View Controller management
    
    func configureEntryViewControllerAt(cursor : EntryCursor) {
        
        let id = ids[cursor]!
        var entryViewController : EntryViewController!
        
        if (entryViewControllers[cursor] == nil) {
            
            // Create the view controller and add it to the correct container.
            entryViewController = EntryViewController(id: id, nibName: "EntryView", bundle: nil)
            entryViewController.delegate = self
            entryViewController.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            
            switch cursor {
                case .Previous:
                    leftContainer.addSubview(entryViewController.view)
                case .Current:
                    middleContainer.addSubview(entryViewController.view)
                case .Next:
                    rightContainer.addSubview(entryViewController.view)
            }
            
            entryViewControllers[cursor] = entryViewController
        } else {
            entryViewController = entryViewControllers[cursor]
        }
        
        entryViewController.configureFor(id)
    }
    
    // ! ScrollView delegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // Determine which page the user has ended scrolling on.
        let width = scrollView.frame.size.width
        let page = scrollView.contentOffset.x / width
        
        // Determine if the user has paged left or right to a new entry.
        if ((page == 0 && ids[.Previous]! > 0) || (page == 2 && ids[.Next]! > 0)) {
        
            if (page == 0) {
                ids[.Next] = ids[.Current]
                ids[.Current] = ids[.Previous]
                ids[.Previous] = 0
            } else {
                ids[.Previous] = ids[.Current]
                ids[.Current] = ids[.Next]
                ids[.Next] = 0
            }
                
            // Update the current view controller and reposition the scroll view immediately.
            self.configureEntryViewControllerAt(cursor: .Current)
            scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
            
            // Request an update for the entry.
            _ = EntryManager.shared.updateRecord(for: ids[.Current]!)
            
            // Reconfigured the other controllers.
            self.configureEntryViewControllerAt(cursor: .Previous)
            self.configureEntryViewControllerAt(cursor: .Next)

        }
    }
    
    // EntryViewController delegate
    
    func entryViewController(_ entryViewController: EntryViewController, didScrollToY y: CGFloat) {
        
        // Resize the journal bar to hidden when the main table scrolls down.
        let height = max(0, min(journalBarHeight, journalBarHeight - y))
        journalBarHeightConstraint.constant = height
        entryNavigationTitleBarHeight.constant = height
    }
    
    func entryViewController(_ entryViewController: EntryViewController, didEnableCellEditiing enabled: Bool) {
        
        // When cell editing may happen, prevent the scrollview from scrolling.
        scrollView.isScrollEnabled = !enabled
    }
    
    func heightForJournalBar() -> CGFloat {
        return journalBarHeight
    }
    
    // ! Notifications
    
    @objc func entryRecordUpdated(notification : Notification) {
        let id = notification.userInfo!["id"] as! Int
        
        // If the middle entry has been updated, refresh the titles based on it.
        if (id == ids[.Current]!) {
            self.configureTitles()
        }
        
        // Configure the relevant entry view controller.
        for (cursor, entryId) in ids {
            if (id == entryId) {
                self.configureEntryViewControllerAt(cursor: cursor)
            }
        }
    }
    
}
