//
//  Word.swift
//  Alias
//
//  Created by Josip Peric on 30/12/2020.
//

import Foundation

class Word {
    let text: String
    var state: AnswerState
    let id: Int

    init(id: Int, text: String, state: AnswerState = .Unknown) {
        self.text = text
        self.state = state
        self.id = id
    }
}
