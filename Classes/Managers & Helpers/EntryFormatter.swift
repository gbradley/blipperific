//
//  HTML.swift
//  Blipperific
//
//  Created by Graham on 11/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryFormatter {
    
    private static var attributedStrings : [String : NSMutableAttributedString] = [:]
    private static var attributedStringHeights : [String : CGFloat] = [:]
    
    // Return an entry's description attributed using a theme.
    static func attributedDescription(response : EntryResponse, theme : Theme) -> NSAttributedString {
        
        let key = NSStringFromClass(type(of: theme)) + String(response.entry.entry_id)
        var attributedString : NSMutableAttributedString
        
        if (attributedStrings[key] == nil) {
        
            let data = response.details!.description_html.data(using: String.Encoding.utf8)
            
            // Attempt to parse the string as HTML, falling back to the provided string.
            do {
                try attributedString = NSMutableAttributedString(data: data!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            } catch {
                attributedString = NSMutableAttributedString(string: response.details!.description)
            }
            
            // Get a range covering the entire string.
            let range = NSRange(location: 0, length: attributedString.length)
            
            // Set the default text color and font.
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: theme.textColor, range: range)
            
            // Set the paragraph attributes.
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = theme.userTextLineSpacing
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
            
            // Enumate through the occurances of the font attribute.
            attributedString.enumerateAttribute(NSAttributedStringKey.font, in: range, options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired) { (value, range, obj) in
                
                let currentFont : UIFont = value as! UIFont
                var replacementFont : UIFont?
                
                // Detect the default font in use and replace it with the themed font.
                if (currentFont.fontName.range(of: "Bold") != nil) {
                    replacementFont = UIFont(name: theme.userBoldTextFontName, size: 13)
                } else if (currentFont.fontName.range(of: "Italic") != nil) {
                    replacementFont = UIFont(name: theme.userItalicTextFontName, size: 13)
                } else {
                    replacementFont = UIFont(name: theme.userTextFontName, size: 13)
                }
                
                attributedString.addAttributes([NSAttributedStringKey.font : replacementFont!], range: range)
            }
            
            attributedStrings[key] = attributedString
        } else {
            attributedString = attributedStrings[key]!
        }
        
        return attributedString
    }
    
    // Return the height of an entry's description when attributed using a theme and rendered inside a container of known width.
    static func heightForDescription(response : EntryResponse, theme : Theme, containerWidth : CGFloat) -> CGFloat {
        
        var height : CGFloat
        let key = NSStringFromClass(type(of: theme)) + String(response.entry.entry_id) + containerWidth.description

        if (attributedStringHeights[key] == nil) {
            
            let attributedString = self.attributedDescription(response: response, theme: theme)
            
            // Determine the height at which the text will be drawn, given the current frame size minus the padding of the text view and its lineFragmentPadding.
            let rect = attributedString.boundingRect(with: CGSize(width: containerWidth, height: 10000), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], context: nil)
            height = ceil(rect.size.height)
        } else {
            height = attributedStringHeights[key]!
        }
        
        return height
    }

}
