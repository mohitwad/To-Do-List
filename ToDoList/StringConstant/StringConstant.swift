//
//  StringConstant.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import Foundation
struct StringConstant {
    struct Error {
        static let nameErrorMessage = "Please enter name"
        static let timeErrorMessage = "Please select time"
        static let saveErrorMessage = "Unable to save data please try again"
        static let deleteErrorMessage = "Unable to delete data please try again"
        static let warning = "You can't update marked or previous task"
    }
    struct Success {
        static let successMessage = "Task saved successfully"
        static let updateMessage = "Task updated successfully"
    }
    struct StaticText {
        static let pending = "Pending"
        static let deletText = "Do you want to delete"
        static let marText = "Do you want to mark "
        static let completed = "as completed, this action can't be undone."
        static let unDoneText = ", this action can’t be undone."
        static let sort = "SortBy"
    }
    struct AlertButtonText {
        static let asc = "Ascending"
        static let desc = "Descending"
        static let clear = "Clear"
        static let cancel = "Cancel"
    }
    struct ControllerName {
        static let addNewTask = "AddNewTaskViewController"
    }
}
