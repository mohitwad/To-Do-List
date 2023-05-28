//
//  UITableView+Extension.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import UIKit
import Foundation

protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
}


extension UITableViewCell: ReusableView {}

extension UITableView {
    
    func registerCell <T:UITableViewCell> (_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueCell<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T? {

        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    func dequeueCell<T: UITableViewCell>(_: T.Type) -> T? {

        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
    }
    
}
