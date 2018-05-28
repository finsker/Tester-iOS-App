//
//  testModel.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 22.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.

import Foundation
class Test {
    
    var questions = [Question]()
    var rightAnswers = 0
    var size = 0
    var currentQuestion: Question?
    
    
    
    
    init(withQuestions: [Question])
    {
        questions = withQuestions
        size = questions.count
        questions.shuffle()
    }
    
    func nextQuestion( ) -> Question? {
        currentQuestion = nil
        if let element = questions.popLast() {
            currentQuestion = element
            return element
        }
        return nil
    }
    
    func nextAnswer(isRight: Bool)-> Bool {
        if isRight, currentQuestion != nil {
            rightAnswers += 1
            currentQuestion = nil
            return true
        }
        return false
    }
}

