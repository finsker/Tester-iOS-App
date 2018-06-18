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
    @IBOutlet weak var startButton: UIButton!
    private var navigator: UINavigationController {
        get {
            return navigationController!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = result {
            let res = String(format: "%.2f", result)
            scoreLabel.text = "Ihr Ergebnis ist: \(res)%"
        }
        setupView()
    }
    
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "showStartPage", sender: sender)
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(toStart))
        view.sliceCorners(radius: 10)
        startButton.sliceCorners(radius: 10)
        startButton.backgroundColor = customColors.defaultColor
    }
    
    @objc func toStart(){
        performSegue(withIdentifier: "showStartPage", sender: nil)
    }
    
}
