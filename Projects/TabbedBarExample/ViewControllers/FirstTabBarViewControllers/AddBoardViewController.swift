//
//  AddBoardViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class AddBoardViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var board_title: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.board_title.delegate = self

        // Do any additional setup after loading the view.
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
          addNewBoard()
        }
        return true
    }
    
    func addNewBoard() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let user_id = UserDefaults.standard.integer(forKey: "user_id")
        APIManager.sharedInstance.alamofireFunction(urlString: "boards", method: .post, paramters: ["board_title":self.board_title.text! as String as AnyObject,"board_primaryowner":user_id as AnyObject]) { (response, message, success) in
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
 

}
