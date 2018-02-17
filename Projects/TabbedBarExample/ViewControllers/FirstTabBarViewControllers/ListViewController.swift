//
//  ListViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    let kLIST_TABLECELL_IDENTIFIER = "ListTableViewCell"
    @IBOutlet weak var uiTableView: UITableView!
    
    let tasks:NSMutableArray = NSMutableArray.init(objects: ["task_title":"Loading tasks","task_description":"","createdAt":""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier:kLIST_TABLECELL_IDENTIFIER )
        uiTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
        addRightBarItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "LIST"
        loadTasks()
    }
    
    func loadTasks() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let board_id = UserDefaults.standard.object(forKey: "board_id")
        let user_id = UserDefaults.standard.integer(forKey: "user_id")
        APIManager.sharedInstance.alamofireFunction(urlString: "task/\(board_id!)/\(user_id)", method: .get, paramters: [:]) { (response, message, success) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
 
            if(success){
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    //                    let boards:BoardsModel =
                    self.tasks.removeAllObjects()
                    self.tasks.addObjects(from: response as! [Any])
                    self.uiTableView.reloadData()
                }
            } else if(!success) {
                CommonAlertManager.sharedInstance.showCommonAlert(viewController: self, message: message!)
            }
        }
    }
    
    // Right bar item
    @objc func addRightBarItem() -> Void {
        let rightBarItem = UIBarButtonItem.init(image: UIImage.init(named: "add"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarItemPressed))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightBarItemPressed(){
          self.performSegue(withIdentifier: "createTask", sender: self)
    }
    
    // Tableview datasource and delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listTableViewCell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: kLIST_TABLECELL_IDENTIFIER, for: indexPath) as! ListTableViewCell
        
        let dict:[String:AnyObject] = (tasks.object(at: indexPath.row) as! [String:AnyObject])
        
        listTableViewCell.lbltitle.text = dict["task_title"] as? String
        listTableViewCell.lblDescription.text = dict["task_description"] as? String
        listTableViewCell.create_date.text = "Severity: \(dict["severity"] ?? "NA" as AnyObject) \t Status: \(dict["status"] ?? "NA" as AnyObject)"
        
  //      configureCell(indexPath: indexPath, incomeListCustomCell: incomeListCustomCell, viewController: viewController)
        listTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        return listTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict:[String:AnyObject] = (tasks.object(at: indexPath.row) as! [String:AnyObject])
        APIManager.sharedInstance.selectedTask = dict
        self.performSegue(withIdentifier: "showTaskDetail", sender: self)
    }


}
