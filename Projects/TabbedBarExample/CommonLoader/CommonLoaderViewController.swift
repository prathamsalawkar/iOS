//
//  CommonLoaderViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 18/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class CommonLoaderViewController: UIViewController {
    
    static let sharedInstance = CommonLoaderViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoader(viewController:UIViewController) -> Void {
        viewController.present(self, animated: true, completion: nil)
    }
    
    func hideLoader() -> Void {
        self.dismiss(animated: true, completion: nil)
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
