//
//  AddTaskViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskSeverity: UITextField!
    @IBOutlet weak var taskStatus: UITextField!
    @IBOutlet weak var taskType: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSave.isEnabled = true
        self.btnSave.alpha = 1.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTask(_ sender: Any) {
        //TODO: Validate the fields
        addTask()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func addTask() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let board_id = UserDefaults.standard.object(forKey: "board_id")
        let user_id = UserDefaults.standard.integer(forKey: "user_id")
        var params:[String:AnyObject] = [:]
        params["board_id"] = board_id! as AnyObject
        params["task_title"] = self.taskTitle.text! as AnyObject
        params["task_description"] = self.taskDescription.text! as AnyObject
        params["status"] = self.taskStatus.text! as AnyObject
        params["severity"] = self.taskSeverity.text! as AnyObject
        params["task_type"] = self.taskType.text! as AnyObject
        params["task_owner"] = user_id as AnyObject
        
        APIManager.sharedInstance.alamofireFunction(urlString: "task", method: .post, paramters: params) { (response, message, success) in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
