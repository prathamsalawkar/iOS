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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.register(UINib.init(nibName: "BoardsTableViewCell", bundle: nil), forCellReuseIdentifier:kBOARDS_TABLECELL_IDENTIFIER )
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let boardsTableViewCell:BoardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: kBOARDS_TABLECELL_IDENTIFIER, for: indexPath) as! BoardsTableViewCell
   
        boardsTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        return boardsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showList", sender: self)
    }
}

