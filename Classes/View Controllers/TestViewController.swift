//
//  TestViewController.swift
//  Blipperific
//
//  Created by Graham on 27/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var scrollContentView : UIView!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var leftTableView : UITableView!
    @IBOutlet var rightTableView : UITableView!
    
    var data = [0, 1, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width, y: 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? 20 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row > 0 ? 50 : 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if (indexPath.row == 0) {
            var index : Int
            if (tableView == self.leftTableView) {
                index = 0;
            } else if (tableView == self.rightTableView) {
                index = 2;
            } else {
                index = 1;
            }
            cell.textLabel?.text = String(data[index])
        } else {
            cell.textLabel?.text = String(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == self.tableView && indexPath.row == 0) {
            scrollView.isScrollEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == self.tableView && indexPath.row == 0) {
            scrollView.isScrollEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView == self.tableView && !scrollView.isScrollEnabled
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView) {
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
                print(data)
                
                // Move back to center
                tableView.reloadData()
                scrollView.contentOffset = CGPoint(x: width, y: 0)
                self.leftTableView.reloadData()
                self.rightTableView.reloadData()
            }
        }
    }
}

