//
//  Question.swift
//  Einbürgerungstest
//
//  Created by Nikita Popov on 20.04.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
struct Answer: Encodable, Decodable{
    var id: Int
    var text: String
    var isRight: Bool
}
struct Question: Encodable, Decodable{
    private(set) var theme: String
    private(set) var textOfQuestion: String
    private(set) var linkOfImageForQuestion: String
    private(set) var answers: [Answer]
    private(set) var id: UInt32

    ///Initialize with [Answer] answers
    init(text: String, imageLink: String, withAnswers: [Answer], id: UInt32, withTheme: String, shuffle: Bool){
        theme = withTheme
        textOfQuestion = text
        linkOfImageForQuestion = imageLink
        self.id = id
        answers = withAnswers
        if shuffle { answers.shuffle() }
    }
    ///Initialize with [String] Answers
    init(text:String, imageLink: String, withAnswers: [String], withTheme: String, shuffle: Bool){
        theme = withTheme
        textOfQuestion = text
        linkOfImageForQuestion = imageLink
        self.id = UInt32(100000.arc4random)
        answers =  withAnswers.map({Answer(id: 500.arc4random, text: $0, isRight: false)})
        answers[0].isRight = true
        if shuffle { answers.shuffle() }
    }
}

