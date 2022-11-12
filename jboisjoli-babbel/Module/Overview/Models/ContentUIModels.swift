//
//  ContentUIModels.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation

struct WordsData: Decodable {
    let text_eng: String
    let text_spa: String
}

struct WordPairUIModel: Hashable {
    let wordEnglish: ContentUIModels
    let wordSpanish: ContentUIModels
    var isCorrect: Bool
}

struct ContentUIModels: Hashable {
    let id: Int
    let word: String
}
