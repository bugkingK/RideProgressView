//
//  ViewController.swift
//  Demo
//
//  Created by moon on 04/10/2019.
//  Copyright © 2019 Bugking. All rights reserved.
//

import UIKit
import RideProgressView

class ViewController: UIViewController {
    
    @IBOutlet weak var rideProgressView:RideProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rideProgressView.animationDuration = 1
    }
    
    @IBAction func onClickStart(_ sender:UIButton) {
        rideProgressView.setProgress(70, animated: true)
    }

}

