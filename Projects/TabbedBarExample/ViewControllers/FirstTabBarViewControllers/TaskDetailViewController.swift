//
//  TaskDetailViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class TaskDetailViewController: UITableViewController,UITextFieldDelegate
{
    let columns = ["Title","Description","Status","Severity","Board Id","Task Type","Task Owner"]

    @IBOutlet weak var uiContentView: UIView!
    var taskDetailView:TaskDetailView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightBarItem()
    }
    @objc func addRightBarItem() -> Void {
        let rightBarItem = UIBarButtonItem.init(image: UIImage.init(named: "add"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarItemPressed))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func rightBarItemPressed(){
        self.view.endEditing(true)
        print(APIManager.sharedInstance.selectedTask)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let tdict = APIManager.sharedInstance.selectedTask
        var dict:[String:AnyObject] = [:]
        dict["task_id"] = tdict["id"]
        dict["task_title"] = tdict["task_title"]
        dict["task_description"] = tdict["task_description"]
        dict["board_id"] = tdict["board_id"]
        dict["status"] = tdict["status"]
        dict["severity"] = tdict["severity"]
        dict["task_type"] = tdict["task_type"]
        dict["task_owner"] = tdict["task_owner"]
        
        print(dict)
        
        APIManager.sharedInstance.alamofireFunction(urlString: "task", method: .patch, paramters: dict) { (response, message, success) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(!success) {
                let uiAlertController =   UIAlertController.init(title: "Response", message: message, preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "OK",
                                                 style: .cancel, handler: nil)
                
                uiAlertController.addAction(cancelAction)
                self.present(uiAlertController, animated: true, completion: nil)
            }
            if(success){
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    //                    let boards:BoardsModel =
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Task Detail"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return columns.count
    }
    
    
    func updateValues(textField:UITextField) {
        switch textField.tag {
        case 0:
            APIManager.sharedInstance.selectedTask["task_title"] = textField.text! as AnyObject
            break
        case 1:
            APIManager.sharedInstance.selectedTask["task_description"] = textField.text! as AnyObject
            break
        case 2:
            APIManager.sharedInstance.selectedTask["status"] = textField.text! as AnyObject
            break
        case 3:
            APIManager.sharedInstance.selectedTask["severity"] = textField.text! as AnyObject
            break
        case 4:
            APIManager.sharedInstance.selectedTask["board_id"] = textField.text! as AnyObject
            break
        case 5:
            APIManager.sharedInstance.selectedTask["task_type"] = textField.text! as AnyObject
            break
        case 6:
            APIManager.sharedInstance.selectedTask["task_owner"] = textField.text! as AnyObject
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateValues(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateValues(textField: textField)
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TaskTableViewCell
        cell.cellValue.tag = indexPath.row
        cell.cellValue.delegate = self
        switch indexPath.row {
        case 0:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = APIManager.sharedInstance.selectedTask["task_title"] as? String
            break
        case 1:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = APIManager.sharedInstance.selectedTask["task_description"] as? String
            break
        case 2:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = APIManager.sharedInstance.selectedTask["status"] as? String
            break
        case 3:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = String(describing: APIManager.sharedInstance.selectedTask["severity"] ?? "" as AnyObject)
            break
        case 4:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = String(describing: APIManager.sharedInstance.selectedTask["board_id"] ?? "" as AnyObject)
            break
        case 5:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = APIManager.sharedInstance.selectedTask["task_type"] as? String
            break
        case 6:
            cell.cellKey.text = columns[indexPath.row]
            cell.cellValue.text = String(describing: APIManager.sharedInstance.selectedTask["task_owner"] ?? "" as AnyObject)
            break
        default:
            cell.cellKey.text = ""
            cell.cellValue.text = ""
        }
        return cell;
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
