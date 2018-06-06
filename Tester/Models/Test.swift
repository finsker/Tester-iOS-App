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
    
}

