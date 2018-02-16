//
//  TaskDetailView.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class TaskDetailView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tblViewCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "kTASKDETAIL_TABLECELL_IDENTIFIER", for: indexPath)
        switch indexPath.row {
        case 1:
            tblViewCell.textLabel?.text = "Title"
            tblViewCell.detailTextLabel?.text = "Task title"
        default:
            tblViewCell.textLabel?.text = "Title"
            tblViewCell.detailTextLabel?.text = "Task title"
        }
        
        return tblViewCell
    }
    

    @IBOutlet weak var tblView: UITableView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    
}
