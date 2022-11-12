//
//  FileJSON.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation

class APIHelper {
    func loadJson(fileName: String) -> [WordsData]? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let words = try? decoder.decode([WordsData].self, from: data)
       else {
            return nil
       }

       return words
    }
}
