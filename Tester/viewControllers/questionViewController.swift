//
//  ViewController.swift
//  Tester
//
//  Created by Nikita Popov on 24.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import UIKit

class questionViewController: UIViewController {
    
    var isAnswerSelected = false
    var isDownoladed = false
    var test = Test()
    var amountOfQuestions: Int?
    var theme: String?
    
    
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
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isDownoladed { startLoadAnimationForUI(); downloadQuestions()}
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    
    
    
    @IBAction func onAnswerTouch(_ sender: UIButton) {
        if !isAnswerSelected {
            test.nextAnswer(isRight: sender.tag == 1)
            sender.backgroundColor = sender.tag == 1 ? customColors.trueSelectedColor : customColors.falseSelectedColor
            isAnswerSelected = true
            
        }
    }
    
    @IBAction func onNextTouch(_ sender: UIButton) {
        
        if isAnswerSelected {
            print("COUNT : ",test.countOfQuestion.description)
            if test.countOfQuestion > 0 {
                isAnswerSelected = false
                showNewQuestion()
                resetView()
            } else {
                performSegue(withIdentifier: "showResult", sender: sender)
            }
        }
    }
    @objc func onImageTouch(sender: UIImageView){
        
        if imageView.tag > 0
        {
            performSegue(withIdentifier: "showImage", sender: sender)
        }
    }
    
   
    
    ///starts download the questions and animating UI
    func downloadQuestions() {
        if let thema = theme, let amount = amountOfQuestions  {
            test.downloadQuestionsAndImages(amount: amount/10, theme: thema) { _ in}
            test.downloadQuestionsAndImages(amount: amount, theme: "General")
            { _ in
                DispatchQueue.main.async {
                    self.isDownoladed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { // чуть замедляет загрузку
                        self.showNewQuestion()
                        self.stopLoadAnimationForUI()
                    }
                }}
        } else {
            print("thema and/or amount didn't set")
        }
        
    }
    
    ///Sets in UI question parameters
    func showNewQuestion(){
        if let question = test.nextQuestion(){
            print("Количество ответов: ",question.answers.count)
            if let newImage = test.getImage(name: question.linkOfImageForQuestion) {
                imageView.image = UIImage(data: newImage)
                imageView.tag = 1
            } else {
                imageView.image = UIImage(named: "questionMark.png")
                imageView.tag = -1
            }
            print(question.linkOfImageForQuestion)
            textOfQuestion = question.textOfQuestion
            for n in question.answers.indices {
                let answer = question.answers[n]
                answerButtons[n].setTitle(answer.text, for: UIControlState.normal)
                answerButtons[n].tag = answer.isRight ? 1 : 0
            }
        } else {
            textOfQuestion = "\(test.score)"
        }
    }
    
    ///set UIElements
    func setupView() {
        
        answerButtons.forEach({
            $0.sliceCorners(radius: 10)
            $0.backgroundColor = customColors.defaultColor
            $0.titleLabel?.lineBreakMode = .byWordWrapping
        })
        
        nextButton.backgroundColor = customColors.defaultColor
        nextButton.sliceCorners(radius: 10)
        
        questionLabel.backgroundColor = customColors.defaultColor
        questionLabel.sliceCorners(radius: 10)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        view.sliceCorners(radius: 10)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onImageTouch))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true

    }
    /// set default backgroundcolor for All Button
    func resetView() {
        
        for but in answerButtons {
            but.backgroundColor = customColors.defaultColor
        }
    }
    
    func startLoadAnimationForUI(){
        nextButton.startLoadAnimation()
        answerButtons.forEach({$0.startLoadAnimation()})
        questionLabel.startLoadAnimation()
    }
    func stopLoadAnimationForUI(){
        nextButton.stopLoadAnimation()
        answerButtons.forEach({$0.stopLoadAnimation()})
        questionLabel.stopLoadAnimation()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Установить в resultViewController поле result
        if segue.identifier == "showResult" {
            if let rvc = segue.destination as? resultsViewController {
                rvc.result = test.score
            }
        }
        if segue.identifier == "showImage" {
            if let sivc = segue.destination as? showImageViewController {
                sivc.image = imageView.image
            }
        }
    }
    
}
