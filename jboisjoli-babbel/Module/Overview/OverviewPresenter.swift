//
//  OverviewPresenter.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation

enum OverviewSection {
    case content(model: [WordPairUIModel])
}

protocol OverviewPresenterProtocol: AnyObject {
    var controller: OverviewControllerProtocol? { get set }
    func viewDidLoad()
    func validateCorrect(word: WordPairUIModel)
    func validateIncorrect(word: WordPairUIModel)
}

protocol OverviewPresenterDelegate: AnyObject {}

class OverviewPresenter {
    internal weak var controller: OverviewControllerProtocol?
    internal weak var delegate: OverviewPresenterDelegate?

    var sections: [OverviewSection] = []

    init(controller: OverviewControllerProtocol,
         delegate: OverviewPresenterDelegate) {
        
        self.controller = controller
        self.delegate = delegate
        self.controller?.presenter = self
    }
}

// MARK: - OverviewPresenterProtocol
extension OverviewPresenter: OverviewPresenterProtocol {
    func viewDidLoad() {
        guard let wordsData = APIHelper().loadJson(fileName: Constants.wordsFileName) else { return }
        
        let section = OverviewFormatter.convert(wordsData)
        self.sections = section
        
        self.controller?.updateSections(sections: self.sections, reload: true)
    }
    
    func validateCorrect(word: WordPairUIModel) {
        word.isCorrect ? self.controller?.correctIncrease() : self.controller?.incorrectIncrease()
    }
    
    func validateIncorrect(word: WordPairUIModel) {
        !word.isCorrect ? self.controller?.correctIncrease() : self.controller?.incorrectIncrease()
    }
}
