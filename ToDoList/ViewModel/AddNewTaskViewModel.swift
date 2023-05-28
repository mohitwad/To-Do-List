//
//  AddNewTaskViewModel.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import Foundation

class AddNewTaskViewModel {
    
    //MARK: - Variable
    private (set) var objTodoItem: Bindable<ToDoListItem?> = Bindable(nil)
    
    //MARK: - init
    init () {}
    
    init(objTodoItem: ToDoListItem) {
        self.objTodoItem.value = objTodoItem
    }
    
    
    //MARK: - Function
    func validationAndSaveData(name: String?, time: String?, date: Date, completion:@escaping(String?,Bool)->Void) {
        guard let name = name, !name.isEmpty else {
            completion(StringConstant.Error.nameErrorMessage,true)
            return
        }
        guard let time = time, !time.isEmpty else {
            completion(StringConstant.Error.timeErrorMessage,true)
            return
        }
        if let objTodo = objTodoItem.value {
            objTodo.name = name
            objTodo.endDate = date
            CoreDataManager.shared.saveContext()
            completion("",false)
        }else {
            CoreDataManager.shared.saveToDo(name: name, endDate: date) { isError in
                completion(StringConstant.Error.saveErrorMessage,!isError)
            }
        }
        
    }
    
}
