//
//  WordService.swift
//  Alias
//
//  Created by Josip Peric on 28/12/2020.
//

import Foundation
import SwiftUI

class WordService {
    
    static var shared = WordService()
    
    private init() {}
    
    var wordListMain: [String] = [] {
        didSet {
            if wordListMain.isEmpty {
                pipe = 1
                updateListOfWords(which: 1)
            }
        }
    }
    
    var wordListReserve: [String] = [] {
        didSet {
            if wordListReserve.isEmpty {
                pipe = 0
                updateListOfWords(which: 2)
            }
        }
    }
    
    var pipe: Int = 0
    
    func updateListOfWords(which: Int) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://random-word-api.herokuapp.com/word?number=10")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String] {
                    if which == 1 {
                        self?.wordListMain = json
                    } else {
                        self?.wordListReserve = json
                    }
                }
        })

        dataTask.resume()
    }
    
    func getNextWord() -> String? {
        return (pipe == 0) ? wordListMain.popLast() : wordListReserve.popLast()
    }
    
}
