//
//  EntryMainTableViewCell.swift
//  Blipperific
//
//  Created by Graham on 25/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
import UIKit

protocol EntryMainTableViewCellDelegate {
    
    func entryMainTableViewCell(_ cell: EntryMainTableViewCell, didScrollTo xRatio: CGFloat)
    
}

class EntryMainTableViewCell : UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!
    
    var prepared : Bool = false
    var delegate : EntryMainTableViewCellDelegate?
    
    func prepareForDisplay() {
        if (!self.prepared) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.resetContentOffset()
                self.prepared = true
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.prepared) {
            self.delegate?.entryMainTableViewCell(self, didScrollTo: self.contentOffsetXRatio())
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (abs(self.contentOffsetXRatio()) == 1) {
            self.resetContentOffset()
        }
    }
    
    func resetContentOffset() {
        self.scrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
    }
        
    func contentOffsetXRatio() -> CGFloat {
        return 1 - (scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
