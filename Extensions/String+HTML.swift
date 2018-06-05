//
//  String+HTML.swift
//  Blipperific
//
//  Created by Graham on 05/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
//  This extension provides a function to apply the current theme's fonts and colours to an HTML string.

import UIKit

extension String {
    
    func attributedHTML(fallback : String = "") -> NSAttributedString {
        
        let currentTheme = Theme.current!
        let data = self.data(using: String.Encoding.utf8)
        var attributedString : NSMutableAttributedString
        
        // Attempt to parse the string as HTML, falling back to the provided string.
        do {
            try attributedString = NSMutableAttributedString(data: data!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            attributedString = NSMutableAttributedString(string: fallback)
        }
        
        // Get a range covering the entire string.
        let range = NSRange(location: 0, length: attributedString.length)
        
        // Set the default text color and font.
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: currentTheme.textColor, range: range)
        
        // Set the paragraph attributes.
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        
        // Enumate through the occurances of the font attribute.
        attributedString.enumerateAttribute(NSAttributedStringKey.font, in: range, options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired) { (value, range, obj) in
            
            let currentFont : UIFont = value as! UIFont
            var replacementFont : UIFont?
            
            // Detect the default font in use and replace it with the themed font.
            if (currentFont.fontName.range(of: "Bold") != nil) {
                replacementFont = UIFont(name: currentTheme.userBoldTextFontName, size: 13)
            } else if (currentFont.fontName.range(of: "Italic") != nil) {
                replacementFont = UIFont(name: currentTheme.userItalicTextFontName, size: 13)
            } else {
                replacementFont = UIFont(name: currentTheme.userTextFontName, size: 13)
            }
            
            attributedString.addAttributes([NSAttributedStringKey.font : replacementFont!], range: range)
        }
        
        return attributedString
    }
    
}
