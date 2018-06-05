//
//  Instruments.swift
//  Tester
//
//  Created by Nikita Popov on 31.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
class Instruments {
    
    /// returns json by link in "Data" format
    private static func getData(by link: String) -> Data? {
        guard let url = URL(string: link) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("url was not found")
            return nil
        }
    }
    ///returns a question by id
    public static func getQuestionBy(id: Int) -> Question? {
        let url = "http://nikbali.ru/queryquestion?id=" + String(id)
        if let data = getData(by: url) {
            if let question = try? JSONDecoder().decode(Question.self, from: data){
                return question
            }
        }
        return nil
    }
    /// return "amount" questions form server
    public static func getRandomQuestions(amount: Int) -> [Question]? {
        var questions = [Question]()
        let url = "http://nikbali.ru/queryquestion?rand=" + String(amount)
        if let data = getData(by: url) {
            if let question = try? JSONDecoder().decode([Question].self, from: data) {
                questions = question
            }
        }
        return questions
    }
    /// returns a Data of Image for UIImage initialization
    public static func getImageData(by name: String) -> Data? {
        if let url = URL(string: "http://nikbali.ru/uploadDir/" + name){
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
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

