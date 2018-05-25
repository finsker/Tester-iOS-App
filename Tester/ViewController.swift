//
//  ViewController.swift
//  Tester
//
//  Created by Nikita Popov on 24.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var test = Test(withQuestions: Data.init().hamburg)
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
            if newValue != "" {
                var image = UIImage(named: newValue)
                imageView.image = image
                imageView.contentMode = UIViewContentMode.scaleAspectFit
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
        sender.backgroundColor = sender.tag == test.currentQuestion?.idOfRightAnswer ? trueSelectedColor : falseSelectedColor
            idOfSelectedAnswer = sender.tag
            isAnswerSelected = true
        }
    }
    
    @IBAction func onNextTouch(_ sender: UIButton) {
        test.nextAnswer(idOfAnswer: idOfSelectedAnswer)
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
                answerButtons[n].tag = answer.id!
            }
        } else {
            //clearView()
            textOfQuestion = "Sie haben \(test.rightAnswers) von \(test.size) richtig beantwortet"
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
    }
    func updateView() {
        for but in answerButtons {
            but.backgroundColor = defaultColor
        }
    }

}

struct Data{
    let hamburg = [
        Question(withText: "Welches Wappen gehört zur Freien und Hansestadt Hamburg?", withImage: "hamburg.frage1.png", withAnswers: ["2","1","3","4"]),
        Question(withText: "Welches ist ein Bezirk von Hamburg? ", withImage: "", withAnswers: ["Altona","Hemelingen","Pankow","Mecklenburgische Seenplatte"]),
        Question(withText: "Für wie viele Jahre wird das Landesparlament in Hamburg gewählt?", withImage: "", withAnswers: ["5","4","3","6"]),
        Question(withText: "Ab welchem Alter darf man in Hamburg bei Kommunalwahlen (Wahl der Bezirksversammlungen) wählen?", withImage: "", withAnswers: ["16", "14","18","20"]),
        Question(withText: "Welche Farben hat die Landesflagge von Hamburg?", withImage: "", withAnswers: ["weiß-rot","blau-weiß-rot","grün-weiß-rot","schwarz-gelb"]),
        Question(withText: "Wo können Sie sich in Hamburg über politische Themen informieren?", withImage: "", withAnswers: ["bei der Landeszentrale für politische Bildung", "beim Ordnungsamt der Gemeinde","bei der Verbraucherzentrale"," bei den Kirchen"]),
        Question(withText: "Welches Bundesland ist ein Stadtstaat? ", withImage: "", withAnswers: ["Hamburg", "Sachsen","Bayern","Thüringen"]),
        Question(withText: "Welches Bundesland ist Hamburg?", withImage: "hamburg.frage8.png", withAnswers: ["3", "1","2","4"]),
        Question(withText: "Wie nennt man den Regierungschef / die Regierungschefin des Stadtstaates Hamburg?", withImage: "", withAnswers: ["Erster Bürgermeister / Erste Bürgermeisterin", "Ministerpräsident / Ministerpräsidentin","Regierender Senator / Regierende Senatorin"," Oberbürgermeister / Oberbürgermeisterin"]),
        Question(withText: "Welchen Senator / welche Senatorin hat Hamburg nicht?", withImage: "", withAnswers: ["Senator / Senatorin für Außenbeziehungen", "Justizsenator / Justizsenatorin","Finanzsenator / Finanzsenatorin","Innensenator / Innensenatorin"]),
        ]
    
}
