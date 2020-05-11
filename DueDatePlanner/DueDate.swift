//
//  DueDate.swift
//  DueDatePlanner
//
//  Created by Xusheng Liu on 5/6/20.
//  Copyright © 2020 Rose-Hulman. All rights reserved.
//

import UIKit
import Firebase

class DueDate: NSObject {
    
    var id: String?
    var name: String!
    var department: String!
    var courseNumber: Int!
    var priorityLevel: Int!
    var dueDate: Timestamp!
    var created: Timestamp!
    var author: String!
    
    let nameKey = "name"
    let departmentKey = "department"
    let courseNumberKey = "courseNumber"
    let priorityLevelKey = "priorityLevel"
    let dueDateKey = "dueDate"
    let createdKey = "created"
    let authorKey = "author"
    
    init(name: String, department: String, courseNumber: Int, priorityLevel: Int, dueDate: Timestamp){
        self.name = name
        self.department = department
        self.courseNumber = courseNumber
        self.priorityLevel = priorityLevel
        self.dueDate = dueDate
        self.created = Timestamp.init()
        self.author = Auth.auth().currentUser!.uid
    }
    
    init(name: String, department: String, courseNumber: Int, priorityLevel: Int, dueDate: Timestamp, created: Timestamp){
        self.name = name
        self.department = department
        self.courseNumber = courseNumber
        self.priorityLevel = priorityLevel
        self.dueDate = dueDate
        self.created = created
        self.author = Auth.auth().currentUser!.uid
    }
    
    init(document: DocumentSnapshot){
        self.id = document.documentID
        let data = document.data()!
        self.name = (data[self.nameKey] as! String)
        self.department = (data[self.departmentKey] as! String)
        self.courseNumber = (data[self.courseNumberKey] as! Int)
        self.priorityLevel = (data[self.priorityLevelKey] as! Int)
        self.dueDate = (data[self.dueDateKey] as! Timestamp)
        self.created = (data[self.createdKey] as! Timestamp)
        self.author = (data[self.authorKey] as! String)
    }
    
    func getData() -> [String: Any?]{
        return [
            self.nameKey: self.name,
            self.departmentKey: self.department,
            self.courseNumberKey: self.courseNumber,
            self.priorityLevelKey: self.priorityLevel,
            self.dueDateKey: self.dueDate,
            self.createdKey: self.created,
            self.authorKey: self.author
        ]
    }
    
}
