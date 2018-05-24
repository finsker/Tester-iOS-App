//
//  ViewController.swift
//  Tester
//
//  Created by Nikita Popov on 24.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func onButtonClick(_ sender: UIButton!) {
        print("view did load")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

