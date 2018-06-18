//
//  Instruments.swift
//  Tester
//
//  Created by Nikita Popov on 31.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
class Instruments {
    
    
    private enum links: String{
        case imageRequest = "http://nikbali.ru/uploadDir/"
        case randomQuestionsRequest = "http://nikbali.ru/queryquestion?rand="
        case questionByIdRequest = "http://nikbali.ru/queryquestion?id="
        case defaultRequest = "http://nikbali.ru/queryquestion?"
    }
    
    
    ///returns Async fetched data in obj
    private static func fetchDataAsync<T: Decodable>(link: String, completion: @escaping (T) -> ()){
        guard let url = URL(string: link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else { return  }
        URLSession.shared.dataTask(with: url){
            (data,resp,err) in
            if let err = err {
                print("failed to fetch data: \(err)"); return
            }
            guard let data = data else { print("no data"); return }
            do {
                let objs = try JSONDecoder().decode(T.self, from: data)
                completion(objs)
            } catch let jsonErr {
                print("Failed to decode Json: \(jsonErr)")
            }
            }.resume()
    }
    
    
    /// returns json by link in "Data" format
    private static func getData(by link: String) -> Data? {
        guard let url = URL(string: link) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            print("data from url was loaded: \(link)")
            return data
        } catch {
            print("no data by URL: \(url)")
            return nil
        }
    }
    
    
    
    ///returns a question by id
    public static func getQuestionBy(id: Int) -> Question? {
        let link = links.questionByIdRequest.rawValue + String(id)
        var question: Question?
        fetchDataAsync(link: link) { (q: Question) in
            question = q
        }
        return question
    }
    
    /// return "amount" questions form server
    public static func getRandomQuestions(amount: Int) -> [Question]? {
        var questions: [Question]?
        let link =  links.randomQuestionsRequest.rawValue + "\(amount.description)&theme=General"
        fetchDataAsync(link: link) {
            (downloadedQuestions: [Question]) in
            questions = downloadedQuestions
        }
        return questions
    }
    
    public static func getRandomQuestions(amount: Int, theme: String) -> [Question]? {
        var questions: [Question]?
        let link =  links.defaultRequest.rawValue + "rand=\(amount.description)&theme=\(theme)"
        fetchDataAsync(link: link) {
            (downloadedQuestions: [Question]) in
            questions = downloadedQuestions
        }
        return questions
    }
    
    public static func getRandomQuestions(amount: Int, theme: String, completion: @escaping ([Question]?)->()) {
        let link =  links.defaultRequest.rawValue + "rand=\(amount.description)&theme=\(theme)"
        fetchDataAsync(link: link) {
            (downloadedQuestions: [Question]) in
            completion(downloadedQuestions)
        }
    }
    
    
    
    
    ///async method that returns in CompletionBlock imageData by link
    public static func getImageDataBy(link: String, completionBlock: @escaping (Data) -> ()) {
        if let url = URL(string: links.imageRequest.rawValue + link) {
            URLSession.shared.dataTask(with: url) { (data,response,errror) in
                //if let response = response { print(response) }
                if let data = data {
                    completionBlock(data)
                }
                }.resume()
        }
    }
    
    
}
