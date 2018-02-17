//
//  BoardsViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class BoardsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    let kBOARDS_TABLECELL_IDENTIFIER = "BoardsTableViewCell"
    @IBOutlet weak var uiTableView: UITableView!
    let boardNames:NSMutableArray = NSMutableArray.init(objects: ["board_title":"Loading Boards..."])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.register(UINib.init(nibName: "BoardsTableViewCell", bundle: nil), forCellReuseIdentifier:kBOARDS_TABLECELL_IDENTIFIER )
        uiTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        addRightBarItem()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    func getBoards() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let user_id = UserDefaults.standard.integer(forKey: "user_id")
        APIManager.sharedInstance.alamofireFunction(urlString: "boards/\(String(describing: user_id))", method: .get, paramters: [:]) { (response, message, success) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if(success){
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    self.boardNames.removeAllObjects()
                    self.boardNames.addObjects(from: response as! [Any])
                    self.uiTableView.reloadData()
                }
            }
            else{
                CommonAlertManager.sharedInstance.showCommonAlert(viewController: self, message: message!)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Boards"
        getBoards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // self.navigationController?.navigationBar.topItem?.title = "Boards";
        //  self.navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    // Right bar item
    @objc func addRightBarItem() -> Void {
        let rightBarItem = UIBarButtonItem.init(image: UIImage.init(named: "add"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarItemPressed))
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightBarItemPressed(){
        self.performSegue(withIdentifier: "createBoard", sender: self) 
    }
    
    
    // Tableview datasource and delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.boardNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let boardsTableViewCell:BoardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: kBOARDS_TABLECELL_IDENTIFIER, for: indexPath) as! BoardsTableViewCell
        
        boardsTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        let dict:[String:AnyObject] = (boardNames.object(at: indexPath.row) as! [String:AnyObject])
        boardsTableViewCell.uiLblTitle.text = dict["board_title"] as? String
        return boardsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict:[String:AnyObject] = (boardNames.object(at: indexPath.row) as! [String:AnyObject])
        UserDefaults.standard.set(dict["id"]!, forKey: "board_id")
        self.performSegue(withIdentifier: "showList", sender: self)
    }
}

