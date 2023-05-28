//
//  UIColor+Additions.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import UIKit


extension UIColor {
    class var blackWithAlpha45: UIColor {
        return UIColor.black.withAlphaComponent(0.45)
    }
    class var textColor: UIColor {
        return UIColor(named: "textColor")!
    }
    class var redColor: UIColor {
        return UIColor(named: "redTextColor") ?? .red
    }
    class var textColorWithAlpha50: UIColor {
        return UIColor(named: "textColor")!.withAlphaComponent(0.5)
    }
}
