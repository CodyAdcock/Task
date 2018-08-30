//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

protocol TaskTableViewCellDelegate: class{
    func finishTask(cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    //IBOutlets
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var dueTextLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    //LandingPad in out Custom TableView Cell
    var task: Task?{
        didSet{
            updateView()
        }
    }
    
    //Make a hook. Allows delegate
    weak var delegate: TaskTableViewCellDelegate?
    
    //updateView func
    func updateView(){
        
        nameTextLabel.text = task?.name
        //format the date proper like
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        guard let due = task?.due else {return}
        dueTextLabel.text = dateFormatter.string(from: due)
        
        //change teh finish button based on if finished or not
        if let isComplete = task?.isComplete {
            if isComplete{
                finishButton.setTitle("Finished", for: .normal)
                finishButton.setTitleColor(.black, for: .normal)
                finishButton.backgroundColor = .green
            }else{
                finishButton.setTitle("Finish", for: .normal)
                finishButton.setTitleColor(.white, for: .normal)
                finishButton.backgroundColor = .red
            }
            
        }
    
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        //call delegate to do specified function
        delegate?.finishTask(cell: self)
        updateView()
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
