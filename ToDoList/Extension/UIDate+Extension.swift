//
//  UIDate+Extension.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import Foundation

extension Date {

    func toString() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let str = dateFormatter.string(from: self)

        return str
    }
}

