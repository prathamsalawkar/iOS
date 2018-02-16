//
//  LoginViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtInputPassword: UITextField!
    @IBOutlet weak var txtInputUsername: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "showFromLoginSegue", sender: self)
        self.txtInputUsername.delegate = self
        self.txtInputPassword.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        APIManager.sharedInstance.alamofireFunction(urlString: "users/login", method: .post, paramters: param as! [String : AnyObject]) { (response, message, success) in
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
                    UserDefaults.standard.set(response!["id"]!, forKey: "user_id")
                    self.performSegue(withIdentifier: "showFromLoginSegue", sender: self)
                }
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
