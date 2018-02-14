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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier:kLIST_TABLECELL_IDENTIFIER )
        uiTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // Do any additional setup after loading the view.
        addRightBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "LIST"
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
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listTableViewCell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: kLIST_TABLECELL_IDENTIFIER, for: indexPath) as! ListTableViewCell
        
  //      configureCell(indexPath: indexPath, incomeListCustomCell: incomeListCustomCell, viewController: viewController)
        listTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        return listTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTaskDetail", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
