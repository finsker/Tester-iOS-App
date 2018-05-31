//
//  Instruments.swift
//  Tester
//
//  Created by Nikita Popov on 31.05.2018.
//  Copyright © 2018 Nikita Popov. All rights reserved.
//

import Foundation
class Instruments {
    
    public static func getJSON(by url: String){
        
    }
    
    public static func getSourceCode(by link: String) -> String? {
        
        guard let url = URL(string: link) else { return nil }
        do {
            let data = try String(contentsOf: url)
            return data
        } catch {
            print("url was not found")
            return nil
        }
    }
}
