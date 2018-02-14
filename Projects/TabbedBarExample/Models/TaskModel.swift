//
//  TaskModel.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 15/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class TaskModel: NSObject {

    private var taskName:String = ""
    private var taskDescription:String = ""
    private var createdDate:Date = Date()
    private var owner:String = ""
    private var status:String = ""
    private var sevearity:String = ""
    private var taskType:String = ""
    
    
    func getTaskName() -> String {
        return taskName
    }
    
    func setTaskName(name:String) -> Void {
        taskName = name
    }
    
    func getTaskDescription() -> String {
        return taskDescription
    }
    
    func setTaskDescription(name:String) -> Void {
        taskDescription = name
    }
    
    
    func getCreatedDate() -> Date {
        return createdDate
    }
    
    func setCreatedDate(date:Date) -> Void {
        createdDate = date
    }
    
    func getOwner() -> String {
        return owner
    }
    
    func setOwner(name:String) -> Void {
        owner = name
    }
    
    func getStatus() -> String {
        return status
    }
    
    func setStatus(name:String) -> Void {
        status = name
    }
    
    func getSevearity() -> String {
        return sevearity
    }
    
    func setSevearity(name:String) -> Void {
        sevearity = name
    }
    
    func getTaskType() -> String {
        return taskType
    }
    
    func setTaskType(name:String) -> Void {
        taskType = name
    }
    
}
