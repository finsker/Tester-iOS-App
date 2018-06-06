//
//  resultsViewController.swift
//  Tester
//
//  Created by Nikita Popov on 05.06.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class resultsViewController: UIViewController {

    
    var result: Double?
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = result {
            let res = String(format: "%.2f", result)
            scoreLabel.text = "Ihr Ergebnis ist: \(res)%"
            
        }
    }
    
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "Show startpage", sender: sender)
    }
    
}
