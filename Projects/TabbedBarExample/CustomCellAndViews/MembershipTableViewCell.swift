//
//  MembershipTableViewCell.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 18/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit
import DropDown

enum SelectionType {
    case selected
    case unSelected
}

class MembershipTableViewCell: DropDownCell  {
    @IBOutlet weak var uiLblTitle: UILabel!
    
    @IBOutlet weak var uiBtnCheckBox: UIButton!
    
    var selectionState:SelectionType = SelectionType.unSelected
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didTouchCheckBox(_ sender: Any) {
        if(selectionState == SelectionType.unSelected){
            selectionState = SelectionType.selected
            uiBtnCheckBox.imageView?.image = UIImage.init(named: "second")
        }
        else{
             selectionState = SelectionType.unSelected
             uiBtnCheckBox.imageView?.image = UIImage.init(named: "first")
        }
    }
    
}
