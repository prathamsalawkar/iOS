//
//  TaskDetailViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController
{

    @IBOutlet weak var uiContentView: UIView!
    var taskDetailView:TaskDetailView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailView = Bundle.main.loadNibNamed("TaskDetailView", owner: self, options: nil)![0] as?  TaskDetailView
        // Do any additional setup after loading the view.
        self.view.addSubview(taskDetailView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
