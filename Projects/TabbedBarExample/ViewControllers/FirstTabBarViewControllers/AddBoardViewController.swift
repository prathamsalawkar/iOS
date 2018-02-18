//
//  AddBoardViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit
import DropDown

 let kNibNameMembershipTableViewCell:String = "MembershipTableViewCell"
 let kTableCellReuseID:String = "reuse_cell"
 let kAddBorads:String = "Add Boards"
 let kSelectMembers:String = "Select Members"

class AddBoardViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MembershipTableViewCellDelegate {
   
    @IBOutlet weak var board_title: UITextField!
    @IBOutlet weak var uiBGAddBoard: UIView!
    @IBOutlet weak var uiBGTableView: UIView!
    @IBOutlet weak var uitable: UITableView!
    @IBOutlet weak var uiBtnAddUser: UIButton!
 //   var allUserDict:NSMutableDictionary = NSMutableDictionary()
    var allUserArr:NSMutableArray = NSMutableArray()
    var usersSelected:NSMutableArray = NSMutableArray()
//    var uiDropDown: DropDown! = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.board_title.delegate = self
      //  setupDropDown()
        loadUIDefaults()
    }
    
    func loadUIDefaults() {
        self.uitable.register(UINib.init(nibName: kNibNameMembershipTableViewCell, bundle: nil), forCellReuseIdentifier: kTableCellReuseID)
         self.uitable.separatorStyle = UITableViewCellSeparatorStyle.none
        showAddMemberView()
        getAllUsersAPI()
    }
    
    func getAllUsersAPI()
    {
        APIManager.sharedInstance.alamofireFunction(urlString: "users", method: .get, paramters: [:]) { (response, message, success) in
 
            if(success){
              //  self.allUserDict = response as! NSMutableDictionary
                self.allUserArr = (response as! NSArray).mutableCopy() as! NSMutableArray
                self.uitable.reloadData()
            }
            else{
                CommonAlertManager.sharedInstance.showCommonAlert(viewController: self, message: message!)
            }
        }
    }
    
    @IBAction func didTouchDropdown(_ sender: Any) {
        //  uiDropDown.show()
        showTableView()
    }
    
    @IBAction func didTouchDoneBtn(_ sender: Any) {
        showAddMemberView()
    }
    
    func showTableView() {
        self.view.bringSubview(toFront: uiBGTableView)
        self.navigationController?.topViewController?.title = kSelectMembers
    }
    
    func showAddMemberView() {
        self.view.bringSubview(toFront: uiBGAddBoard)
        self.navigationController?.topViewController?.title = kAddBorads
    }
    
    // Table view delegate and datasource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUserArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let membershipTableViewCell:MembershipTableViewCell =   tableView.dequeueReusableCell(withIdentifier:kTableCellReuseID) as! MembershipTableViewCell
        membershipTableViewCell.delegate = self
        let model = allUserArr.object(at: indexPath.row) as! NSDictionary
        membershipTableViewCell.uiLblTitle.text = (model.value(forKey: "username") as! String)
        return membershipTableViewCell
    }
    
    // tableview cell delegate
    func didTouchCheckBox(membershipTableViewCell: MembershipTableViewCell)
    {
        if(usersSelected.contains(membershipTableViewCell.uiLblTitle.text!))
        {
            usersSelected.remove(membershipTableViewCell.uiLblTitle.text!)
        }
        else
        {
            usersSelected.add(membershipTableViewCell.uiLblTitle.text!)
        }
    }
    
    
    // text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            addNewBoard()
        }
        return true
    }
    
    func addNewBoard() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
       
        APIManager.sharedInstance.alamofireFunction(urlString: "boards", method: .post, paramters: getParam() as! [String : AnyObject]) { (response, message, success) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if(success){
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    self.navigationController?.popViewController(animated: true)
                }
            } else if(!success) {
                CommonAlertManager.sharedInstance.showCommonAlert(viewController: self, message: message!)
            }
        }
    }
    
    
    func getParam() -> NSMutableDictionary
    {
        let params = NSMutableDictionary()
        let user_id = UserDefaults.standard.integer(forKey: "user_id")
        params.setValue(self.board_title.text, forKey: "board_title")
        params.setValue(user_id, forKey: "board_primaryowner")
        return params
    }
    
//    func setupDropDown() {
//        uiDropDown.anchorView = uiBtnAddUser
//        uiDropDown.bottomOffset = CGPoint(x: 0, y: uiBtnAddUser.bounds.height)
//        uiDropDown.dataSource = [
//            "10 €",
//            "20 €",
//            "30 €"
//        ]
//        
//        // Action triggered on selection
//        uiDropDown.selectionAction = { [weak self] (index, item) in
//            self?.uiBtnAddUser.setTitle(item, for: .normal)
//        }
//    }
//    
//    func setupDefaultDropDown() {
//        DropDown.setupDefaultAppearance()
//        uiDropDown.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
//        uiDropDown.customCellConfiguration = nil
//    }
//    
//    func customizeDropDown(_ sender: AnyObject) {
//        let appearance = DropDown.appearance()
//        
//        appearance.cellHeight = 60
//        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
//        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
//        //        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
//        appearance.cornerRadius = 10
//        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
//        appearance.shadowOpacity = 0.9
//        appearance.shadowRadius = 25
//        appearance.animationduration = 0.25
//        appearance.textColor = .darkGray
//        //        appearance.textFont = UIFont(name: "Georgia", size: 14)
//        
//        /*** FOR CUSTOM CELLS ***/
//        //        uiDropDown.cellNib = UINib(nibName: "MembershipTableViewCell", bundle: nil)
//        //
//        //        uiDropDown.customCellConfiguration =  { (index: Index, item: String, cell: DropDownCell) -> Void in
//        //            guard let cell = cell as? MembershipTableViewCell else { return }
//        //
//        //            // Setup your custom UI components
//        //        //    cell.suffixLabel.text = "Suffix \(index)"
//        //        }
//        /*** ---------------- ***/
//        
//    }
//    
    
}
