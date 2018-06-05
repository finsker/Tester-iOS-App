//
//  ViewController.swift
//  Tester
//
//  Created by Nikita Popov on 24.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var test = Test(withQuestions: Instruments.getRandomQuestions(amount: 10)!, shuffle: false)
    var defaultColor = #colorLiteral(red: 0.8274509804, green: 0.8431372549, blue: 0.831372549, alpha: 1)
    var trueSelectedColor = #colorLiteral(red: 0.8459352261, green: 1, blue: 0.662603968, alpha: 1)
    var falseSelectedColor = #colorLiteral(red: 1, green: 0.7718817678, blue: 0.6401711963, alpha: 1)
    var isAnswerSelected = false
    var idOfSelectedAnswer = 0
    
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    public var textOfQuestion: String? {
        get {
            return questionLabel.text
        }
        set {
            questionLabel.text = newValue ?? nil
        }
    }
    public var linkOfImage: String {
        get {
            return "sorry"
        }
        set {
            if let data = Instruments.getImageData(by: newValue) {
                imageView.image = UIImage(data: data)
            } else {
                imageView.image = UIImage(named: "questionMark.png")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewQuestion()
        setupView()
    }
    
    @IBAction func onAnswerTouch(_ sender: UIButton) {
        if !isAnswerSelected {
            sender.backgroundColor = test.nextAnswer(isRight: sender.tag == 1) ? trueSelectedColor : falseSelectedColor
            idOfSelectedAnswer = sender.tag
            isAnswerSelected = true
        }
    }
    
    @IBAction func onNextTouch(_ sender: UIButton) {
        
        isAnswerSelected = false
        showNewQuestion()
        updateView()
        
        
    }
    
    func showNewQuestion(){
        if let question = test.nextQuestion(){
            linkOfImage = question.linkOfImageForQuestion
            textOfQuestion = question.textOfQuestion
            for n in question.answers.indices {
                let answer = question.answers[n]
                answerButtons[n].setTitle(answer.text, for: UIControlState.normal)
                answerButtons[n].tag = answer.isRight ? 1 : 0
            }
        } else {
            //clearView()
            textOfQuestion = "\(test.score)"
        }
    }
    func setupView() {
        
        for but in answerButtons {
            but.layer.cornerRadius = 5
            but.clipsToBounds = true
            but.backgroundColor = defaultColor
        }
        nextButton.backgroundColor = defaultColor
        nextButton.layer.cornerRadius = 5
        nextButton.clipsToBounds = true
        questionLabel.backgroundColor = defaultColor
        questionLabel.layer.cornerRadius = 5
        questionLabel.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
    }
    func updateView() {
        for but in answerButtons {
            but.backgroundColor = defaultColor
        }
    }
    
}
