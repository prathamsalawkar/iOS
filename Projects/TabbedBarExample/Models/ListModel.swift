//
//  ListModel.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 15/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class ListModel: NSObject {

    private var listName:String = ""
    private var listDescription:String = ""
    private var createdDate:Date = Date()
    
    func getListName() -> String {
        return listName
    }
    
    func setListName(name:String) -> Void {
        listName = name
    }
    
    func getListDescription() -> String {
        return listDescription
    }
    
    func setListDescription(name:String) -> Void {
        listDescription = name
    }
 
    
    func getCreatedDate() -> Date {
        return createdDate
    }
    
    func setCreatedDate(date:Date) -> Void {
        createdDate = date
    }
}
