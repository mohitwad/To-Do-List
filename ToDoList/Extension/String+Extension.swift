//
//  String+Extension.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import Foundation
import UIKit

extension String {
    func strikeThrough()->NSAttributedString{
            let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            return attributeString
        }
    func removeStrikeThrough() -> NSAttributedString {
           let attributeString = NSMutableAttributedString(string: self)
           attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
           return attributeString
       }
}
