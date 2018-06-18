//
//  testModel.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 22.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.

import Foundation
class Test {
    
    private var questions = [Question]()
    private var rightAnswers = 0
    private var size = 0
     var images = [String:Data]() {
        didSet{
            print("Something with images ")
        }
    }
    
    public func getImage(name: String) -> Data? {
        return images[name]
    }
    
    public var hasNextQuestionImage: Bool {
        get{
            return questions.last?.linkOfImageForQuestion != "questionMark.png" ? true : false
        }
    }
    
    ///returns Score value
    public  var score: Double {
        return Double(rightAnswers) / Double(size) * 100.0
    }
    ///returns count of remaining questions
    public var countOfQuestion: Int {
        get{
            return questions.count
        }
    }
    
    ///empty initializer
    init(){
        questions = [Question]()
        size = 0
    }
    init(amount: Int, thema: String){
        //questions = Instruments.getRandomQuestions(amount: amount, theme: thema)
    }
    /// standtart initializer
    init(withQuestions: [Question], shuffle: Bool)
    {
        questions = withQuestions
        size = questions.count
        
        
        if shuffle { questions.shuffle() }
    }
    
    
    ///pops and returns a question from questions array
    func nextQuestion() -> Question? {
        return questions.popLast()
    }
    ///accepts answer for current question
    func nextAnswer(isRight: Bool) {
        rightAnswers += isRight ? 1 : 0
    }
    
    

    public func downloadQuestionsAndImages(amount: Int, theme: String, completion: @escaping (Int)->()){
        Instruments.getRandomQuestions(amount: amount, theme: theme){
            (qs) in
            guard let qs = qs else { print("unreadable data"); return }
            self.questions.append(contentsOf: qs)
            self.size += qs.count
            let links = qs.filter({$0.linkOfImageForQuestion != "questionMark.png"}).map({$0.linkOfImageForQuestion})
            if links.count > 0  {
                for link in links {
                    print("Downloading image")
                    Instruments.getImageDataBy(link: link) {
                        (data) in
                        self.images[link] = data
                    }
                }
            }
            completion(self.questions.count)
        }
        
    }

    
  
}

