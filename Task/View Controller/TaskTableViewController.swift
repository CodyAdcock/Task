//
//  TaskTableViewController.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController, TaskTableViewCellDelegate,  NSFetchedResultsControllerDelegate {
    
    //Meet Protocol
    func finishTask(cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let task = TaskController.shared.tasks[indexPath.row]
        
        task.isComplete = !task.isComplete
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        }catch {
            print("There was an error in \(#function) \(error) \(error.localizedDescription)")
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "due", ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell
        let task = fetchedResultsController.fetchedObjects?[indexPath.row]
        
        //grab the hook
        cell?.delegate = self
        cell?.task = task
        
        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            TaskController.shared.remove(task: task)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case.insert:
            guard let indexPath = indexPath else {return}
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailView",
            let indexPath = tableView.indexPathForSelectedRow {
            let task = fetchedResultsController.fetchedObjects?[indexPath.row]
            let taskVC = segue.destination as? TaskDetailTableViewController
            
            taskVC?.task = task
        }
        
    }
    
}
