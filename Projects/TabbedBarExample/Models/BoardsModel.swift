//
//  BoardsModel.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 15/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class BoardsModel: NSObject {

    private var boardName:String = ""
    
    func getBoardName() -> String {
        return boardName
    }
    
    func setBoardName(name:String) -> Void {
        boardName = name
    }
    
}
