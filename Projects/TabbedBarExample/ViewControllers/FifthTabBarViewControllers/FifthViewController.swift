//
//  FifthViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit


class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = nil
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.topViewController?.title = "Settings"
    }
    @IBAction func didTouchAddNewMember(_ sender: Any) {
        self.performSegue(withIdentifier: "registerNewMember", sender: self)
    }
    
    @IBAction func didTouchLogout(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func toggleNotification(_ sender: Any) {
        
    }
    
    @IBAction func didTouchShowProfile(_ sender: Any) {
        
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
