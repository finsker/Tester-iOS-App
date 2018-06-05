//
//  testModel.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 22.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.

import Foundation
class Test {
    
    var questions = [Question]()
    private var rightAnswers = 0
    private var size = 0
    var currentQuestion: Question?
    var score: Double {
        return Double(rightAnswers) / Double (size)
    }
    
    
    /// standtart initializer
    init(withQuestions: [Question], shuffle: Bool)
    {
        questions = withQuestions
        size = questions.count
        if shuffle { questions.shuffle() }
    }
    ///pops and returns a question from questions array
    func nextQuestion( ) -> Question? {
        currentQuestion = nil
        if let element = questions.popLast() {
            currentQuestion = element
            return element
        }
        return nil
    }
    ///accepts answer for current question
    func nextAnswer(isRight: Bool) -> Bool {
        if isRight, currentQuestion != nil {
            rightAnswers += 1
            currentQuestion = nil
            return true
        }
        return false
    }
    
}

