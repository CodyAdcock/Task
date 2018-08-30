//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //landing pad
    var task: Task?{
        didSet{
            loadViewIfNeeded()
            updateView()
        }
    }
    
    //IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateView(){
        
        guard let task = task else {return}
        
        title = task.name
        nameTextField.text = task.name
        //unwrap date
        guard let due = task.due else {return}
        datePicker.date = due
        notesTextView.text = task.notes
        setFinishButton()
        
    }
    
    //func for if statements for color and stuff on button
    func setFinishButton(){
        guard let task = task else {return}
        if task.isComplete{
            finishButton.setTitle("Finished", for: .normal)
            finishButton.setTitleColor(.black, for: .normal)
            finishButton.backgroundColor = .green
        }else{
            finishButton.setTitle("Finish", for: .normal)
            finishButton.setTitleColor(.white, for: .normal)
            finishButton.backgroundColor = .red
        }
    }
  
    //Finish Button Tapped
    @IBAction func finishButtonTapped(_ sender: Any) {
        guard let task = task else {return}
        TaskController.shared.toggleFinish(task: task)
        setFinishButton()
    }
    
    //Save Button Tapped
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let notes = notesTextView.text else {return}
        if let task = task{
            TaskController.shared.update(task: task, name: name, notes: notes, due: datePicker.date)
        } else{
            TaskController.shared.add(taskWithName: name, notes: notes, due: datePicker.date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
