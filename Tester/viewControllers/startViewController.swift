//
//  startPageViewController.swift
//  Tester
//
//  Created by Nikita Popov on 05.06.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class startViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var amountOfQuestionsField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var losButton: UIButton!
    
    var pickerData: [String] = ["Baden-Württemberg","Bayern","Berlin","Brandenburg","Bremen","Hamburg","Hessen","Mecklenburg-Vorpommern","Niedersachsen","Nordrhein-Westfalen","Rheinland-Pfalz","Saarland","Sachsen","Sachsen-Anhalt","Schleswig-Holstein","Thüringen"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    @IBAction func onLosClick(_ sender: UIButton) {
        performSegue(withIdentifier: "showQuestion", sender: sender)
    }
    
    @IBAction func onStepperTouch(_ sender: UIStepper) {
        amountOfQuestionsField.text = Int(sender.value).description
    }
    
    
    
    
    
    ///picker's methods implementation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    ///setup UIElements
    private func setupUIElements() {
        stepper.stepValue = 10
        stepper.maximumValue = 300
        stepper.wraps = true
        stepper.minimumValue = 0
        stepper.autorepeat = true
        stepper.value = 30
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        view.sliceCorners(radius: 10)
        
        navigationController?.navigationBar.barTintColor = customColors.backgroundColor
        
        losButton.sliceCorners(radius: 10)
        losButton.backgroundColor = customColors.defaultColor
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion" {
            if let qvc = segue.destination as? questionViewController {
                amountOfQuestionsField.text = Int(amountOfQuestionsField.text!) != nil ? amountOfQuestionsField.text : 10.description
                qvc.amountOfQuestions = Int(amountOfQuestionsField.text!)
                qvc.theme = pickerData[picker.selectedRow(inComponent: 0)]
            }
        }
    }
}





