//
//  DeleteAlertView.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import UIKit

class DeleteAlertView: UIView {
    
    //MARK: - Iboutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet var lblMessage: UILabel!
    
    //MARK: - Variable
    var okAction:((ToDoListItem?,Bool)->Void)?
    var todo:ToDoListItem?
    var isMarkComplete = false
    
    //MARK: - init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DeleteAlertView", owner: self, options: nil)
        contentView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(contentView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func addView(on view: UIView, selectHandler: @escaping (ToDoListItem?,Bool) -> Void) {
        
        var contains = false
        for subview in view.subviews {
            
            if let _ = subview as? DeleteAlertView {
                contains = true
                break
            }
        }
    
        if !contains {
            hide()
            view.addSubview(self)
        }
        okAction = selectHandler
    }
    
    func show() {
        
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
    
    func updateWarningText(todo:ToDoListItem,isMarkComplete:Bool) {
        self.todo = todo
        self.isMarkComplete = isMarkComplete
        if let name = todo.name{
            if isMarkComplete {
                self.lblMessage.text = "\(StringConstant.StaticText.marText) \"\(name)\" \(StringConstant.StaticText.completed)"
            }else{
                self.lblMessage.text = "\(StringConstant.StaticText.deletText) \"\(name)\" \(StringConstant.StaticText.unDoneText)"
            }
           
        }
    }
    
    //MARK: - Action
    @IBAction func actionOK(_ sender: Any) {
        okAction?(todo, isMarkComplete)
    }
    @IBAction func actionCancel(_ sender: Any) {
        hide()
    }
    
}
