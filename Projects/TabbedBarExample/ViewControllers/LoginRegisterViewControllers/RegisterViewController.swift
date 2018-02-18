//
//  RegisterViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var uiTxtFieldUsername: UITextField!
    @IBOutlet weak var uiTxtFieldPassword: UITextField!
    @IBOutlet weak var uiTxtFieldFirstName: UITextField!
    @IBOutlet weak var uiTxtFieldLastName: UITextField!
    @IBOutlet weak var uiTxtFieldEmail: UITextField!
    @IBOutlet weak var uiTxtFieldRole: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Register"
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    @IBAction func validateRegistration(_ sender: Any) {
        // self.performSegue(withIdentifier: "showFromRegisterSegue", sender: self)
        if(validateInputs())
        {
            performRegistration()
        }
        else
        {
            CommonAlertManager.sharedInstance.showCommonAlert(viewController: self, message: "Please input all fields")
        }
    }
    
    func performRegistration()
    {
        APIManager.sharedInstance.alamofireFunction(urlString: "users/register", method: .post, paramters: getParam() as! [String : AnyObject]) { (response, message, success) in
            
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
                    //   self.performSegue(withIdentifier: "showFromLoginSegue", sender: self)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }
    
    func getParam() -> NSMutableDictionary {
        let param:NSMutableDictionary = NSMutableDictionary()
        
        param.setValue(uiTxtFieldUsername.text, forKey: "username")
        param.setValue(uiTxtFieldPassword.text, forKey: "password")
        param.setValue(uiTxtFieldFirstName.text, forKey: "first_name")
        param.setValue(uiTxtFieldLastName.text, forKey: "last_name")
        param.setValue(uiTxtFieldEmail.text, forKey: "user_email")
        param.setValue(uiTxtFieldRole.text, forKey: "role")
        return param
    }
    
    func validateInputs() -> Bool {
        if(uiTxtFieldUsername.text != ""
            && uiTxtFieldPassword.text != ""
            && uiTxtFieldFirstName.text != ""
            && uiTxtFieldLastName.text != ""
            && uiTxtFieldEmail.text != ""
            && uiTxtFieldRole.text != ""){
            return true
        }
        return false
    }
    
}
