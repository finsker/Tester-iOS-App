//
//  Question.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 20.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
struct Answer:Codable{
    var text: String?
    var id: Int?
}
struct Question: Codable{
    
    private(set) var textOfQuestion: String
    private(set) var linkOfImageForQuestion: String
    private(set) var answers: Array<Answer>
    private(set) var idOfRightAnswer: Int?
    private(set) var idOfQuestion: UInt32?
    
    init(withText text:String, withImage image: String, withAnswers: [String],withId id: UInt32 ){
        textOfQuestion = text
        linkOfImageForQuestion = image
        idOfQuestion = id
        answers = Array<Answer>()
        for str in withAnswers {
            answers.append(Answer(text: str, id: 16.arc4random))
        }
        idOfRightAnswer = answers.first?.id
        answers.shuffle()
    }
    init(withText text:String, withImage image: String, withAnswers: [String]){
        textOfQuestion = text
        linkOfImageForQuestion = image
        idOfQuestion = UInt32(100000.arc4random)
        answers = Array<Answer>()
        for str in withAnswers {
            answers.append(Answer(text: str, id: 16.arc4random))
        }
        idOfRightAnswer = answers.first?.id
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
