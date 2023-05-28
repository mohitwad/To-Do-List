//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import Foundation
class ToDoListViewModel {
    private (set) var arrToDoList: Bindable<[ToDoListItem]> = Bindable([])
    private (set) var sortBy: Bindable<SortType> = Bindable(.clear)
    
    //MARK: - Function
    func fetchToDoList(sort:SortType) {
        arrToDoList.value = CoreDataManager.shared.getAllTodos(sort: sort)
    }
    
    func deleteTask(task:ToDoListItem, completion:@escaping(String?)->Void) {
        CoreDataManager.shared.deleteTask(task: task) { [weak self] isError in
            guard let `self` = self else{return}
            if isError {
                self.arrToDoList.value.remove(at: self.getdeleteTaskIndex(todo: task))
                completion(nil)
            }else {
                completion(StringConstant.Error.deleteErrorMessage)
            }
        }
    }
    
    func getdeleteTaskIndex(todo:ToDoListItem)->Int {
        if let index = arrToDoList.value.firstIndex(where: { objTodo in
            return objTodo.id == todo.id
        }) {
            return index
        }
        return 0
    }
    
    func markCompleteTask(task:ToDoListItem, completion:@escaping(String?)->Void) {
        CoreDataManager.shared.completeTask(todo: task) { [weak self] isError in
            guard let `self` = self else{return}
            if isError {
                task.markedStatus = true
                self.arrToDoList.value[self.getdeleteTaskIndex(todo: task)] = task
                completion(nil)
            }else {
                completion(StringConstant.Error.deleteErrorMessage)
            }
        }
    }
}

enum SortType {
    case asc
    case desc
    case clear
}
