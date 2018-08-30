//
//  TaskController.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()

    //create
    func add(taskWithName name: String, notes: String?, due: Date?){
        guard let notes = notes,
            let due = due else {return}
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    //read
    
    //update
    func update(task: Task, name: String, notes: String?, due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    //delete
    func remove(task: Task){
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    //toggle finish
    func toggleFinish(task: Task){
        task.isComplete = !task.isComplete
    }
    
    //persistence
    func saveToPersistentStore(){
        do{
            try CoreDataStack.context.save()
        }catch {
            print("There was an error in \(#function) \(error) \(error.localizedDescription)")
        }
    }
    
    private func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //MARK: Properties
    var tasks: [Task]{
        return fetchTasks()
    }

    
//    //MOCK DATA
//    let mockTasks: [Task] = {
//        let task1 = Task(name: "Get 1 Done", notes: "This is number 1", due: Date())
//        let task2 = Task(name: "Get 2 Done", notes: "This is number 2", due: Date())
//        let task3 = Task(name: "Get 3 Done", notes: "This is number 3", due: Date())
//        let task4 = Task(name: "Get 4 Done", notes: "This is number 4", due: Date())
//
//        return [task1, task2, task3, task4]
//    }()
}
