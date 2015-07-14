//
//  SecondViewController.swift
//  FlipTransion
//
//  Created by BourneWeng on 15/7/13.
//  Copyright (c) 2015年 Bourne. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func shouldBack(sender: AnyObject) {
        (self.transitioningDelegate as! UIViewController).dismissViewControllerAnimated(true, completion: nil)
    }

}
