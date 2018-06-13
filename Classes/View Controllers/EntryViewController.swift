//
//  TestViewController.swift
//  Blipperific
//
//  Created by Graham on 27/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate {
    
    func entryViewController(_ entryViewController : EntryViewController, didScrollToY y : CGFloat)
    
    func heightForJournalBar() -> CGFloat
    
}

class EntryViewController: JournalExploreViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet var entryTableView : UITableView!
    
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
    
    var journalBarHeight : CGFloat!
    var id : Int!
    var record : EntryRecord!
    var sections : [SectionType] = []
    var rows : [SectionType : [RowType]] = [:]
    var entryStatisticsView : EntryStatisticsView?
    
    var delegate : JournalViewController?
    
    convenience init(id : Int, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the initial values.
        self.id = id
        self.record = EntryManager.shared.record(for: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the table views.
        entryTableView.allowsSelection = false
        entryTableView.separatorStyle = .none
        entryTableView.register(UINib(nibName: "EntryTableViewPhotoCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewPhotoCell")
        entryTableView.register(UINib(nibName: "EntryTableViewTitleCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewTitleCell")
        entryTableView.register(UINib(nibName: "EntryTableViewDescriptionCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewDescriptionCell")
        entryTableView.register(UINib(nibName: "EntryTableViewMetadataCell", bundle:nil), forCellReuseIdentifier: "EntryTableViewMetadataCell")
        
        entryTableView.dataSource = self
        entryTableView.delegate = self
        
        // Hide the table view if there is no entry to display.
        entryTableView.isHidden = self.id == 0
        
        _ = self.configureSections()
    }
    
    func configureFor(_ id : Int) {
        
        // Determine if the ID has changed.
        let entryHasChanged = id != self.id
        
        // Update the ID and record.
        self.id = id
        self.record = EntryManager.shared.record(for: id)
    
        // If the ID has changed, reset the sections.
        if (entryHasChanged) {
            sections = []
        }
        
         // Hide the table view if there is no entry to display.
        entryTableView.isHidden = self.id == 0

        let updateSections = self.configureSections()
        if (entryHasChanged) {
            entryTableView.reloadData()
        } else {
            
            // Because row animations aren't applied to section footers, wait until the section is inserted before displaying the footer manually.
            let footerView = self.entryStatisticsView
            if (footerView != nil) {
                footerView?.isHidden = true
            }
            
            entryTableView.insertSections(IndexSet(updateSections), with: .fade)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                // If the footer has been created, show it now.
                if (footerView != nil) {
                    footerView?.alpha = 0
                    footerView?.isHidden = false
                    UIView.animate(withDuration: 0.1, animations: {
                        footerView?.alpha = 1
                    })
                }
            
            }
        }
    }
    
    // Configure the table sections based on the stored response, and return indexes of any new sections.
    func configureSections() -> [Int] {
        var insertSections : [Int] = []
        if let response = record.response {
            
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
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        return rows[sectionType]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height : CGFloat
        let rowType = self.rowType(at: indexPath)
        
        if (rowType == RowType.Spacer) {
            height = self.delegate!.heightForJournalBar()
        } else if (rowType == RowType.Photo) {
            height = self.heightForPhoto()
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
        let cell = entryTableView.dequeueReusableCell(withIdentifier: "EntryTableViewPhotoCell") as! EntryTableViewPhotoCell
        cell.photoImageView.sd_setImage(with: URL(string: record.response!.entry.image_url), completed: nil)
        return cell
    }
    
    func getTitleCell() -> EntryTableViewTitleCell {
        let cell = entryTableView.dequeueReusableCell(withIdentifier: "EntryTableViewTitleCell") as! EntryTableViewTitleCell
        cell.titleLabel.text = record.response!.entry.title
        return cell
    }
    
    func getDescriptionCell() -> EntryTableViewDescriptionCell {
        let cell = entryTableView.dequeueReusableCell(withIdentifier: "EntryTableViewDescriptionCell") as! EntryTableViewDescriptionCell
        cell.descriptionTextView.attributedText = EntryFormatter.attributedDescription(response: record.response!, theme : Theme.current!)
        return cell
    }
    
    func getMetadataCell() -> EntryTableViewMetadataCell {
        let cell = entryTableView.dequeueReusableCell(withIdentifier: "EntryTableViewMetadataCell") as! EntryTableViewMetadataCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = sections[section]
        return sectionType == .Detail ? 44 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view : UIView?
        let sectionType = sections[section]
        
        if (sectionType == .Detail) {
            
            // Create an instance of the statistics view as the footer.
            let statisticsView = Bundle.main.loadNibNamed("EntryStatisticsView", owner: self, options: nil)![0] as! EntryStatisticsView
            statisticsView.configureFor(record.response!)
            statisticsView.onActionTapped { (action) in
                print("doing " + action)
            }
            
            // Store a reference to the view so we can access it later (the table's `footerView` method only works with HeaderFooterViews).
            self.entryStatisticsView = statisticsView
            view = statisticsView
        }
        return view
    }
    
    // ! Cell editing
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    // ! Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.entryViewController(self, didScrollToY: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // When the main table view has stopped moving, we want to ensure the journal bar is either fully hidden or fully visible.
        if (!decelerate) {
            self.adjustMainTableScrollPositionFor(dragTo : scrollView.contentOffset)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // When the main table view will decelerate, we want to adjust the target Y coordinate to ensure the journal bar is either fully hidden or fully visible.
        if (velocity.y != 0) {
            self.adjustMainTableScrollPositionFor(decelerationTo: targetContentOffset)
        }
    }
    
    // Main table scrolling adjustments.
    
    func adjustMainTableScrollPositionFor(dragTo contentOffset : CGPoint) {
        let y = contentOffset.y
        let height = self.delegate!.heightForJournalBar()
        if (y < height) {
            entryTableView.setContentOffset(CGPoint(x: 0, y: y < height / 2 ? 0 : height), animated: true)
        }
    }
    
    func adjustMainTableScrollPositionFor(decelerationTo targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        let height = self.delegate!.heightForJournalBar()
        if (y < height) {
            targetContentOffset.pointee.y = y < height / 2 ? 0 : height
        }
    }
    
    // Size calculations
    func heightForPhoto() -> CGFloat {
        let width = self.view.frame.size.width
        return fabs((width) / CGFloat(record.response!.entry.image_aspect_ratio!))
    }
    
    func heightForDescription() -> CGFloat {
        return EntryFormatter.heightForDescription(response: record.response!, theme: Theme.current!, containerWidth: self.view.frame.size.width - 20)
    }
    
}

