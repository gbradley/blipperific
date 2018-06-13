//
//  ErrorMessage.swift
//  Blipperific
//
//  Created by Graham on 13/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
//  This class provides a simple way to display an error message to the user, regardless of where they are in the application. It does this by injecting a view
//  into the window's subviews and adjusting the suvview's bounds. This does have some issues:
//
//  - ideally the message would appear at the top of the screen, rather than the bottom, but this seems to interfere with nav bar inset calculations;
//  - currently the message view does not respond to orientation changes, although this is a minor issue because the message is only displayed for a short period;
//  - the class ignores further messages until the current message is cleared, although this is also minor because there really shouldn't be many error messages!

import UIKit

class ErrorMessage {
    
    var errorMessageView : ErrorMessageView!
    var errorMessageHeight : CGFloat!
    
    func display(message : String) {
        
        if (errorMessageView == nil) {
            let window = UIApplication.shared.keyWindow!
            let subview = window.subviews.first!
            
            // Calculate the height of the message, taking into account the labels's padding and font.
            let rect = message.boundingRect(with: CGSize(width: subview.frame.size.width - 20, height: 10000), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: [NSAttributedStringKey.font : UILabel.appearance().font], context: nil)
            errorMessageHeight = ceil(rect.size.height) + 20
            
            // Create the view and set its frame offset by the the calculated height.
            errorMessageView = Bundle.main.loadNibNamed("ErrorMessageView", owner: self, options: nil)![0] as! ErrorMessageView
            errorMessageView.messageLabel.text = message
            errorMessageView.frame = CGRect(x: 0, y: subview.frame.size.height, width: subview.frame.size.width, height: errorMessageHeight)
            window.addSubview(errorMessageView)
            
            // Animate the frame changes.
            UIView.animate(withDuration: 0.3) {
                self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: -self.errorMessageHeight)
                
                var frame = subview.frame
                frame.size.height = frame.size.height - self.errorMessageHeight
                subview.frame = frame
            }
            
            // Automatoically remove the error message after a few seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.remove()
            }
        }
    }
    
    func remove() {
        
        let window = UIApplication.shared.keyWindow!
        let subview = window.subviews.first!
        
        // Animate the reversed frame changes, and remove the view when done.
        UIView.animate(withDuration: 0.3, animations: {
            
            self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: self.errorMessageHeight)
            subview.frame = UIScreen.main.bounds
            
        }) { (complete) in
            
            self.errorMessageView.removeFromSuperview()
            self.errorMessageView = nil
            
        }
    }
    
}
