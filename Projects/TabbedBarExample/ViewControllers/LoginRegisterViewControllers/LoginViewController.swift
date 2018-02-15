//
//  LoginViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtInputPassword: UITextField!
    @IBOutlet weak var txtInputUsername: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
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
        self.navigationController?.title = "Login"
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    @IBAction func didEndEditing(_ sender: Any) {
        if(txtInputPassword.text != "" && txtInputUsername.text != ""){
            btnLogin.isEnabled = true
            btnLogin.alpha = 1
        }else{
            btnLogin.isEnabled = false
            btnLogin.alpha = 0.5
        }
    }
    
    @IBAction func performLogin(_ sender: Any) {
        let param:NSMutableDictionary = NSMutableDictionary()
 
        param.setValue(txtInputUsername.text, forKey: "username")
        param.setValue(txtInputPassword.text, forKey: "password")
        
        APIManager.sharedInstance.alamofireFunction(urlString: "user/login", method: .post, paramters: param as! [String : AnyObject]) { (response, message, success) in
            
            let uiAlertController =   UIAlertController.init(title: "Response", message: message, preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlertController, animated: true, completion: nil)
            
            if(success){
                self.performSegue(withIdentifier: "showFromLoginSegue", sender: self)
            }
            
        }
        
        
    }
    
    @IBAction func performRegister(_ sender: Any) {
         self.performSegue(withIdentifier: "registerSegue", sender: self)
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
