//
//  ViewController.swift
//  Tester
//
//  Created by Nikita Popov on 24.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class questionViewController: UIViewController {
    
    var defaultColor = #colorLiteral(red: 0.8274509804, green: 0.8431372549, blue: 0.831372549, alpha: 1)
    var trueSelectedColor = #colorLiteral(red: 0.8459352261, green: 1, blue: 0.662603968, alpha: 1)
    var falseSelectedColor = #colorLiteral(red: 1, green: 0.7718817678, blue: 0.6401711963, alpha: 1)
    
    var isAnswerSelected = false
    
    var test: Test?
    var amountOfQuestions: Int?
    var thema: String?
    
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    public var textOfQuestion: String? {
        get {
            return questionLabel.text
        }
        set {
            questionLabel.text = newValue ?? "error was occured"
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
        downloadQuestions()
        showNewQuestion()
        setupView()
    }
    
    
    func downloadQuestions() {
        if let thema = thema, let amount = amountOfQuestions  {
            if let questions = Instruments.getRandomQuestions(amount: amount) {
                //Как нибудь добавить проверку. Если вопросы не загрузились, то подождать и попробовать пару раз
                test = Test(withQuestions: questions, shuffle: false)
                print(thema)
            } else {
                print("no connection with Internet")
            }
        } else {
            print("thema and/or amount didn't set")
        }
    }
    
    @IBAction func onAnswerTouch(_ sender: UIButton) {
        if !isAnswerSelected {
            if let t = test {
                t.nextAnswer(isRight: sender.tag == 1)
                sender.backgroundColor = sender.tag == 1 ? trueSelectedColor : falseSelectedColor
                isAnswerSelected = true
                
            }
        }
    }
    
    @IBAction func onNextTouch(_ sender: UIButton) {
        if let t = test, isAnswerSelected {
            print("COUNT : ",t.countOfQuestion.description)
            if t.countOfQuestion > 0 {
                isAnswerSelected = false
                showNewQuestion()
                updateView()
            } else {
                performSegue(withIdentifier: "Show result", sender: sender)
            }
        }
    }
    
    func showNewQuestion(){
        if let t = test {
            if let question = t.nextQuestion(){
                linkOfImage = question.linkOfImageForQuestion
                textOfQuestion = question.textOfQuestion
                for n in question.answers.indices {
                    let answer = question.answers[n]
                    answerButtons[n].setTitle(answer.text, for: UIControlState.normal)
                    answerButtons[n].tag = answer.isRight ? 1 : 0
                }
            } else {
                //clearView()
                textOfQuestion = "\(t.score)"
            }
        }
    }
    
    ///set UIElements
    func setupView() {
        
        for but in answerButtons {
            but.layer.cornerRadius = 5
            but.clipsToBounds = true
            but.backgroundColor = defaultColor
            but.titleLabel?.lineBreakMode = .byWordWrapping
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Установить в resultViewController поле result
        if segue.identifier == "Show result" {
            if let rvc = segue.destination as? resultsViewController, let t = test {
                rvc.result = t.score
            }
        }
    }
    
}
