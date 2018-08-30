//
//  TaskTableViewController.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, TaskTableViewCellDelegate {
    
    //Meet Protocol
    func finishTask(cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let task = TaskController.shared.tasks[indexPath.row]
        
        task.isComplete = !task.isComplete
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell
        let task = TaskController.shared.tasks[indexPath.row]
        
        //grab the hook
        cell?.delegate = self
        cell?.task = task
        
        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailView",
            let indexPath = tableView.indexPathForSelectedRow {
            let task = TaskController.shared.tasks[indexPath.row]
            let taskVC = segue.destination as? TaskDetailTableViewController
            taskVC?.task = task
        }
        
    }
    
}
