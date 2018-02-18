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

protocol MembershipTableViewCellDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func didTouchCheckBox(membershipTableViewCell: MembershipTableViewCell)
}

class MembershipTableViewCell: UITableViewCell
{
    @IBOutlet weak var uiLblTitle: UILabel!
    @IBOutlet weak var uiBtnCheckBox: UIButton!
    
    var selectionState:SelectionType = SelectionType.unSelected
    var delegate:MembershipTableViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didTouchCheckBox(_ sender: Any)
    {
        if(selectionState == SelectionType.unSelected){
            selectionState = SelectionType.selected
            uiBtnCheckBox.setImage(UIImage.init(named: "checked"), for: UIControlState.normal)
        }
        else{
            selectionState = SelectionType.unSelected
            uiBtnCheckBox.setImage(UIImage.init(named: "unchecked"), for: UIControlState.normal)
        }
        
        delegate?.didTouchCheckBox(membershipTableViewCell: self)
    }
    
}
