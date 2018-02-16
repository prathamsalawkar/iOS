//
//  RegisterViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 14/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

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
        self.performSegue(withIdentifier: "showFromRegisterSegue", sender: self)
    }
    
    func performRegistration()
    {
        let param:NSMutableDictionary = NSMutableDictionary()
        
//        param.setValue(txtInputUsername.text, forKey: "username")
        
        APIManager.sharedInstance.alamofireFunction(urlString: "users/register", method: .post, paramters: param as! [String : AnyObject]) { (response, message, success) in
            
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
                    self.performSegue(withIdentifier: "showFromLoginSegue", sender: self)
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
