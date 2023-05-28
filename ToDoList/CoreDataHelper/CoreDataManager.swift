//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import Foundation
import CoreData

 class CoreDataManager {
     
     static let shared = CoreDataManager()
     
     private init() {}
     
     func deleteTask(task objToDolist: ToDoListItem, completion: @escaping (Bool) -> Void) {
         let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
         request.predicate = NSPredicate(format: "id = %@", objToDolist.id!.uuidString)
         
         do {
             let context = persistentContainer.viewContext
             let result = try context.fetch(request)
             if result.count > 0 {
                 let task = result.first!
                 context.delete(task)
                 saveContext()
                 completion(true)
             }
         } catch let err {
             print(err.localizedDescription)
         }
     }
     
     func completeTask(todo objToDolist: ToDoListItem, completion: @escaping (Bool) -> Void) {
         let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
         request.predicate = NSPredicate(format: "id = %@", objToDolist.id!.uuidString)
         
         do {
             let result = try persistentContainer.viewContext.fetch(request)
             if result.count > 0 {
                 let task = result.first!
                 task.markedStatus = true
                 saveContext()
                 completion(true)
             }
         } catch let err {
             print(err.localizedDescription)
         }
     }
     
     func getAllTodos (sort:SortType) -> [ToDoListItem] {
         let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
         if sort == .asc{
             request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ToDoListItem.endDate), ascending: true)]
         }else if sort == .desc {
             request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ToDoListItem.endDate), ascending: false)]
         }
         var arrToDolist = [ToDoListItem]()
         
         do {
             arrToDolist = try persistentContainer.viewContext.fetch(request)
         } catch let err {
             print(err.localizedDescription)
         }
         
         return arrToDolist
     }
     
     func saveToDo(name: String, endDate: Date, completion: @escaping (Bool) -> Void) {
         let task = ToDoListItem(context: persistentContainer.viewContext)
         task.name = name
         task.endDate = endDate
         task.id = UUID()
         saveContext()
         completion(true)
     }
     
     // MARK: - Core Data stack

     lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "ToDoList")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()

     // MARK: - Core Data Saving support

     func saveContext () {
         let context = persistentContainer.viewContext
         if context.hasChanges {
             do {
                 try context.save()
             } catch {
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
             }
         }
     }
 }
