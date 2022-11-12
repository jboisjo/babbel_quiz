//
//  OverviewFormatter.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation

class OverviewFormatter {
    static func convert(_ words: [WordsData]) -> [OverviewSection] {
        var sections: [OverviewSection] = []
        
        let initialList = OverviewFormatter.returnInitialList(words)
        let models = OverviewFormatter.returnShuffledAndRandomWordPairList(initialList)
    
        sections = [.content(model: models)]
        
        return sections
    }
    
    static func returnInitialList(_ words: [WordsData]) -> [WordPairUIModel] {
        return words.enumerated().compactMap { index, model in
            WordPairUIModel(wordEnglish: ContentUIModels(id: index, word: model.text_eng), wordSpanish: ContentUIModels(id: index, word: model.text_spa), isCorrect: true)
        }
    }
    
    static func returnShuffledAndRandomWordPairList(_ currentList: [WordPairUIModel]) -> [WordPairUIModel] {
        let currentListShuffled = currentList.shuffled()
        var chunkedList: [WordPairUIModel] = []
        var multiArrayGameList: [[WordPairUIModel]] = [[]]
        
        for i in 0...currentListShuffled.count - 1 {
            // Create chunk of 4 to create a rounding of 25%
            if i % 4 != 0 {
                // Add none-maatching word
                let wordListE = currentListShuffled[currentListShuffled.count-i].wordEnglish // grab the last index to make them un-matched
                let wordlistS = currentListShuffled[i-1].wordSpanish // grab the first index to make them unmatched
                
                let pair = WordPairUIModel(wordEnglish: wordListE,
                                    wordSpanish: wordlistS,
                                    isCorrect: false)
                chunkedList.append(pair)
            } else {
                // Add matching word
                chunkedList.append(WordPairUIModel(wordEnglish: currentListShuffled[i].wordEnglish,
                                            wordSpanish: currentListShuffled[i].wordSpanish,
                                            isCorrect: true))
                
                
                let shuffledChunk = chunkedList.shuffled() // shuffle again to make sure it doesnt follows
                multiArrayGameList.append(shuffledChunk)
                
                chunkedList = [] // reset for creating a new chunk
            }
        }
        
        let gameList = multiArrayGameList.flatMap { $0 }

        return gameList
    }
}
