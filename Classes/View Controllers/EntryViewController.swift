//
//  TestViewController.swift
//  Blipperific
//
//  Created by Graham on 27/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryViewController: JournalViewController, UITableViewDataSource, UITableViewDelegate , UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var scrollContentView : UIView!
    
    @IBOutlet var mainTableView : UITableView!
    @IBOutlet var leftTableView : UITableView!
    @IBOutlet var rightTableView : UITableView!
    
    @IBOutlet var journalBar : UIView!
    @IBOutlet var journalUsernameButton : UsernameButton!
    
    // Stores references to journal bar height contstraint and initial value.
    var journalBarHeightConstraint : NSLayoutConstraint!
    var journalBarHeight : CGFloat!
    var entryNavigationTitleBarHeight : NSLayoutConstraint!
    
    // Stores calculated strings and heights
    var entryDescription : NSAttributedString!
    var entryDescriptionHeightForWidth : [CGFloat:CGFloat] = [:]
    var entryPhotoHeightForWidth : [CGFloat:CGFloat] = [:]
    
    enum SectionType : Int {
        case Summary = 0
        case Detail = 1
        case Comments = 2
    }
    
    enum RowType : Int {
        case Spacer = 0
        case Photo = 1
        case Title = 2
        case Description = 3
        case Metadata = 4
        case Other = 5
    }
    
    var id : Int!
    var sections : [SectionType] = []
    var rows : [SectionType : [RowType]] = [:]
    var entryStatisticsView : EntryStatisticsView?
    var expectsUpdates : Bool = false
    
    var data = [0, 1, 2]
    
    var entry : [String : Any] = [
        "title" : "This is a dog!",
        "image" : "Dog",
        "image_ratio" : 0.725,
        "description" : "Failed!",
        "description_html" : "Lorem ipsum dolor amet <b>subway</b> tile gochujang <a href='https://www.google.com'>flat white<a> synth. Small batch hot chicken meggings, literally palo santo vexillologist drinking vinegar meditation godard next level. Synth VHS meh, lyft offal blog bicycle rights man braid skateboard freegan truffaut sartorial selfies jianbing viral. PBR&B bicycle rights meh, messenger bag YOLO ethical meditation typewriter godard squid microdosing glossier kinfolk swag single-origin coffee. Tofu squid echo park skateboard pitchfork hoodie mustache marfa artisan banh mi narwhal. Brunch asymmetrical master cleanse, pitchfork kinfolk af mumblecore neutra hella. Man braid etsy lomo quinoa street art scenester neutra kickstarter franzen +1 iceland.<br /><br />Pop-up fanny pack shabby chic, kale chips live-edge glossier cardigan cornhole fixie YOLO waistcoat literally. Narwhal pickled snackwave ethical food truck bicycle rights. Pabst af keffiyeh chartreuse leggings aesthetic health goth subway tile hell of succulents marfa bespoke sustainable. Cardigan ramps brooklyn offal, roof party neutra literally +1 kale chips air plant affogato actually messenger bag austin poke. Gastropub bespoke freegan lomo pitchfork meggings helvetica synth sriracha actually cloud bread occupy mlkshk. Health goth keffiyeh pork belly, normcore chia brooklyn disrupt activated charcoal schlitz green juice tote bag vegan blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah."
        ]
    
    var response : EntryResponse?
    
    convenience init(id : Int, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the ID.
        self.id = id
        
        // Listen for entry updates.
        NotificationCenter.default.addObserver(self, selector: #selector(self.entryRecordUpdated), name: .entryManagerDidUpdateRecord, object: nil)
        
        // Get the response for the ID, which may request more info in the background and call `entryRecordUpdated()`.
        self.response = EntryManager.shared.record(for: id).response
        self.expectsUpdates = EntryManager.shared.updateRecord(for: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoCellNib = UINib(nibName: "EntryTableViewPhotoCell", bundle:nil);
        
        // Configure the table views.
        mainTableView.allowsSelection = false
        mainTableView.separatorStyle = .none
        mainTableView.register(photoCellNib, forCellReuseIdentifier: "EntryTableViewPhotoCell")
        mainTableView.register(UINib(nibName: "EntryTableViewTitleCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewTitleCell")
        mainTableView.register(UINib(nibName: "EntryTableViewDescriptionCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewDescriptionCell")
        mainTableView.register(UINib(nibName: "EntryTableViewMetadataCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewMetadataCell")
        
        leftTableView.separatorStyle = .none
        leftTableView.register(photoCellNib, forCellReuseIdentifier: "EntryTableViewPhotoCell")
        
        rightTableView.separatorStyle = .none
        rightTableView.register(photoCellNib, forCellReuseIdentifier: "EntryTableViewPhotoCell")
        
        self.configureTitles()
        _ = self.configureSections()
        self.registerConstraints()
    }
    
    // Configure the navigation tiles and buttons based on the stored response.
    func configureTitles() {
        
        var username : String = ""
        var journalTitle : String = ""
        var dateStr : String = ""
        
        if let response = self.response {
            username = response.entry.username
            dateStr = String(response.entry.date_stamp)
            
            if let details = response.details {
                journalTitle = details.journal_title
            }
        }
        
        // Configure the title.
        self.title = username
        self.setCustomNavigation(title: journalTitle, dateStr: dateStr, username: username)
        
        // Configure the journal bar.
        self.journalUsernameButton.setTitle(username == "" ? "" : "by " + username, for: .normal)
        self.journalUsernameButton.sizeToFit()
    }
    
    // Configure the table sections based on the stored response, and return indexes of any new sections.
    func configureSections() -> [Int] {
        var insertSections : [Int] = []
        if let response = self.response {
            
            if (!sections.contains(.Summary)) {
                insertSections.append(sections.count)
                sections.append(.Summary)
                
                rows[.Summary] = [.Spacer, .Photo]
                
                // Add the title if its non-empty.
                if (response.entry.title != "") {
                    rows[.Summary]!.append(.Title)
                }
            }
            
            if response.details != nil {
                
                if (!sections.contains(.Detail)) {
                    insertSections.append(sections.count)
                    sections.append(.Detail)
                    
                    rows[.Detail] = []
                    
                    // Add the description if its non-empty.
                    if (response.entry.title != "") {
                        rows[.Detail]!.append(.Description)
                    }
                    
                    rows[.Detail]!.append(.Metadata)
                }
            }
        }
        return insertSections
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
            self.navigationItem.titleView?.isHidden = self.expectsUpdates
        }
        (self.navigationItem.titleView as! EntryNavigationTitleView).configure(title: title, date: dateStr, username: username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the initial content size & offset of the scroller.
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height - journalBarHeight)
        self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
    }
    
    func rowType(at indexPath : IndexPath) -> RowType {
        var rowType : RowType!
        let section = sections[indexPath.section]
        if (indexPath.row < rows[section]!.count) {
            rowType = rows[section]![indexPath.row]
        } else {
            rowType = .Other
        }
        return rowType
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.mainTableView ? sections.count : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        return tableView == self.mainTableView ? rows[sectionType]!.count : 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height : CGFloat
        let rowType = self.rowType(at: indexPath)
        
        if (rowType == RowType.Spacer) {
            height = journalBarHeight
        } else if (rowType == RowType.Photo) {
            height = self.heightForPhoto() + 10
        } else if (rowType == RowType.Title) {
            height = 41
        } else if (rowType == RowType.Description) {
            height = self.heightForDescription() + 4
        } else if (rowType == RowType.Metadata) {
            height = 44
        } else {
            height = 50
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let rowType = self.rowType(at: indexPath)
        
        if (rowType == RowType.Photo) {
            cell = self.getPhotoCell()
        } else if (rowType == RowType.Title) {
            cell = self.getTitleCell()
        } else if (rowType == RowType.Description) {
            cell = self.getDescriptionCell()
        } else if (rowType == RowType.Metadata) {
            cell = self.getMetadataCell()
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        return cell
    }
    
    func getPhotoCell() -> EntryTableViewPhotoCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "EntryTableViewPhotoCell") as! EntryTableViewPhotoCell
        cell.photoImageView.sd_setImage(with: URL(string: response!.entry.image_url), completed: nil)
        return cell
    }
    
    func getTitleCell() -> EntryTableViewTitleCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "EntryTableViewTitleCell") as! EntryTableViewTitleCell
        cell.titleLabel.text = response!.entry.title
        return cell
    }
    
    func getDescriptionCell() -> EntryTableViewDescriptionCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "EntryTableViewDescriptionCell") as! EntryTableViewDescriptionCell
        cell.descriptionTextView.attributedText = self.attributedDescription()
        return cell
    }
    
    func getMetadataCell() -> EntryTableViewMetadataCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "EntryTableViewMetadataCell") as! EntryTableViewMetadataCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == self.mainTableView && indexPath.row == RowType.Spacer.rawValue) {
            scrollView.isScrollEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == self.mainTableView && indexPath.row == RowType.Spacer.rawValue) {
            scrollView.isScrollEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = sections[section]
        return sectionType == .Detail ? 35 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view : UIView?
        let sectionType = sections[section]
        
        if (sectionType == .Detail) {
            
            // Create an instance of the statistics view as the footer.
            let statisticsView = Bundle.main.loadNibNamed("EntryStatisticsView", owner: self, options: nil)![0] as! EntryStatisticsView
            statisticsView.configureFor(response!)
            statisticsView.onActionTapped { (action) in
                print("doing " + action)
            }
            
            // If updates are expected, hide the statistics view, otherwise just show it immediately.
            statisticsView.isHidden = self.expectsUpdates
            
            // Store a reference to the view so we can access it later (the table's `footerView` method only works with HeaderFooterViews).
            self.entryStatisticsView = statisticsView
            view = statisticsView
        }
        return view
    }
    
    // ! Cell editing
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView == self.mainTableView && !scrollView.isScrollEnabled
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    // ! Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.mainTableView) {
            
            
            // Resize the journal bar to hidden when the main table scrolls down.
            let height = max(0, min(journalBarHeight, journalBarHeight - scrollView.contentOffset.y))
            journalBarHeightConstraint.constant = height
            entryNavigationTitleBarHeight.constant = height
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView) {
            
            // Determine which page the user has ended scrolling on.
            let width = scrollView.frame.size.width
            let page = scrollView.contentOffset.x / width
            if (page == 0 || page == 2) {
                // User has paged to start / end
                
                if (page == 2) {
                    data.removeFirst()
                    data.append(data.last! + 1)
                } else {
                    data.removeLast()
                    data.insert(data.first! - 1, at: 0)
                }
                
                // Move back to center
                self.mainTableView.reloadData()
                scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
                self.leftTableView.reloadData()
                self.rightTableView.reloadData()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView == self.mainTableView) {
            
            // When the main table view has stopped moving, we want to ensure the journal bar is either fully hidden or fully visible.
            if (!decelerate) {
                self.adjustMainTableScrollPositionFor(dragTo : scrollView.contentOffset)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (scrollView == self.mainTableView) {
            
            // When the main table view will decelerate, we want to adjust the target Y coordinate to ensure the journal bar is either fully hidden or fully visible.
            if (velocity.y != 0) {
                self.adjustMainTableScrollPositionFor(decelerationTo: targetContentOffset)
            }
        }
    }
    
    // Main table scrolling adjustments.
    
    func adjustMainTableScrollPositionFor(dragTo contentOffset : CGPoint) {
        let y = contentOffset.y
        if (y < journalBarHeight) {
            mainTableView.setContentOffset(CGPoint(x: 0, y: y < journalBarHeight / 2 ? 0 : journalBarHeight), animated: true)
        }
    }
    
    func adjustMainTableScrollPositionFor(decelerationTo targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        if (y < journalBarHeight) {
            targetContentOffset.pointee.y = y < journalBarHeight / 2 ? 0 : journalBarHeight
        }
    }
    
    // Size calculations
    func heightForPhoto() -> CGFloat {
        
        let width = self.view.frame.size.width
        var height = entryPhotoHeightForWidth[width]
        if (height == nil) {
            height = fabs((width - 20) / CGFloat(response!.entry.image_aspect_ratio!))
            entryPhotoHeightForWidth[width] = height
        }
        
        return height!
    }
    
    func heightForDescription() -> CGFloat {
    
        let width = self.view.frame.size.width
        var height = entryDescriptionHeightForWidth[width]
        if (height == nil) {
        
            let attributedString = self.attributedDescription()
            
            // Determine the height at which the text will be drawn, given the current frame size minus the padding of the text view and its lineFragmentPadding.
            let rect = attributedString.boundingRect(with: CGSize(width: width - 20, height: 10000), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], context: nil)
            height = ceil(rect.size.height)
        }
        
        return height!
    }
    
    func attributedDescription() -> NSAttributedString {
        if (entryDescription == nil) {
            entryDescription = (response!.details!.description_html).attributedHTML(fallback: response!.details!.description)
        }
        return entryDescription
    }
    
    // ! Notifications
    
    @objc func entryRecordUpdated(notification : Notification) {
        if (self.id == (notification.userInfo!["id"] as! Int)) {
            
            // Update the stored response.
            self.response = (notification.userInfo!["record"] as! EntryRecord).response!
            
            // Reconfigure the titles and table sections.
            self.configureTitles()
            self.mainTableView.insertSections(IndexSet(self.configureSections()), with: .fade)
            
            // Because row animations aren't applied to section footers, wait until the section is inserted before displaying the footer manually.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                let footerView = self.entryStatisticsView!
                let titleView = self.navigationItem.titleView!
                
                footerView.alpha = 0
                footerView.isHidden = false
                titleView.alpha = 0
                titleView.isHidden = false
                UIView.animate(withDuration: 0.1, animations: {
                    footerView.alpha = 1
                    titleView.alpha = 1
                })
            }
        }
    }
    
}

