//
//  showImageViewController.swift
//  Tester
//
//  Created by Nikita Popov on 15.06.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class showImageViewController: UIViewController {

    
    var image: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        view.backgroundColor = customColors.backgroundColor
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }

}
