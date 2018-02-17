//
//  ThirdViewController.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 10/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit
import YouTubePlayer

class ThirdViewController: UIViewController {

    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = nil
        
        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=_3YlqWWnI6s")
        videoPlayer.loadVideoURL(myVideoURL! as URL)
        videoPlayer.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Calender"
    }
    


}

