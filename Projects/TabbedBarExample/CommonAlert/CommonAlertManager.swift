//
//  CommonAlertManager.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 17/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class CommonAlertManager: NSObject {
 static let sharedInstance = CommonAlertManager()
    
    func showCommonAlert(viewController:UIViewController, message:String) -> Void
    {
        let uiAlertController =   UIAlertController.init(title: "Response", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        uiAlertController.addAction(cancelAction)
        viewController.present(uiAlertController, animated: true, completion: nil)
    }
    
}
