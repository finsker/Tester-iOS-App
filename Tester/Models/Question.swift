//
//  Question.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 20.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
struct Answer: Codable{
    var text: String
    var isRight: Bool
}
struct Question: Codable{
    
    private(set) var textOfQuestion: String
    private(set) var linkOfImageForQuestion: String
    private(set) var answers: Array<Answer>
    private(set) var id: UInt32
    
    ///В данный момент инициализатор устроен так, что, верный ответ нужно подавать первым в списке ответов. Его верность автоматически уст. true
    init(withText text:String, withImage imageLink: String, withAnswers: [String], with id: UInt32){
        textOfQuestion = text
        linkOfImageForQuestion = imageLink
        self.id = id
        answers =  withAnswers.map({Answer(text: $0, isRight: false)})
        answers[0].isRight = true
        answers.shuffle()
        self.id = id
    }
    ///В данный момент инициализатор устроен так, что, верный ответ нужно подавать первым в списке ответов. Его верность автоматически уст. true
    init(withText text:String, withImage imageLink: String, withAnswers: [String]){
        textOfQuestion = text
        linkOfImageForQuestion = imageLink
        self.id = UInt32(100000.arc4random)
        answers =  withAnswers.map({Answer(text: $0, isRight: false)})
        answers[0].isRight = true
        answers.shuffle()
    }
}

extension Int{
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension MutableCollection {
    mutating func shuffle(){
        let c = count
        guard c > 1 else {
            return
        }
        for (firstUnshuffled, unshuffledCount) in zip(indices,stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
