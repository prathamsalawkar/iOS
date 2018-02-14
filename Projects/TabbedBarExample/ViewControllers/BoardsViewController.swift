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
    let boardNames:NSArray = NSArray.init(objects: "iOS","Android","Web","Kindle")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.register(UINib.init(nibName: "BoardsTableViewCell", bundle: nil), forCellReuseIdentifier:kBOARDS_TABLECELL_IDENTIFIER )
        uiTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        addRightBarItem()
        // Do any additional setup after loading the view.
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title = "Boards"
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Right bar item
    @objc func addRightBarItem() -> Void {
        let rightBarItem = UIBarButtonItem.init(image: UIImage.init(named: "add"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarItemPressed))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightBarItemPressed(){
        
    }
    
    
    // Tableview datasource and delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let boardsTableViewCell:BoardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: kBOARDS_TABLECELL_IDENTIFIER, for: indexPath) as! BoardsTableViewCell
   
        boardsTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        boardsTableViewCell.uiLblTitle.text = boardNames.object(at: indexPath.row) as! String
        return boardsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showList", sender: self)
    }
}

