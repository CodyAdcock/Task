//
//  Task+Convenience.swift
//  Task
//
//  Created by Cody on 8/29/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import CoreData

extension Task{
    @discardableResult
    convenience init(name: String, notes: String, due: Date, context: NSManagedObjectContext = CoreDataStack.context){
        //I don't get this line below
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
}
