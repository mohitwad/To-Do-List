//
//  UIViewController+Extension.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import UIKit
extension UIViewController {
    func showAlert(_ title: String?, _ message: String, _ completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showActionSheet(_ title: String?, _ message: String,_ selected: SortType, _ completion: @escaping (SortType) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let ascendingButton = UIAlertAction(title: StringConstant.AlertButtonText.asc, style: .default, handler: {  _ in
            completion(.asc)
        })
        let descendingButton = UIAlertAction(title: StringConstant.AlertButtonText.desc, style: .default, handler: {  _ in
            completion(.desc)
        })
        let clearButton = UIAlertAction(title: StringConstant.AlertButtonText.clear, style: .default, handler: {  _ in
            completion(.clear)
        })
        let cancel = UIAlertAction(title: StringConstant.AlertButtonText.cancel, style: .cancel, handler: {  _ in
            completion(.clear)
        })
        if selected == .asc {
            ascendingButton.setValue(true, forKey: "checked")
        }else if selected == .desc{
            descendingButton.setValue(true, forKey: "checked")
        }
        alert.addAction(ascendingButton)
        alert.addAction(descendingButton)
        alert.addAction(clearButton)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
