//
//  OverviewPresenterTest.swift
//  jboisjoli-babbelTests
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import XCTest
@testable import jboisjoli_babbel

class OverviewPresenterTest: XCTestCase {
    
    var presenter: OverviewPresenter!
    var controller: OverviewControllerMock!
    var delegate: OverviewDelegateMock!
    
    var wordPairMocked: [WordsData]?
    var sections: [OverviewSection] = []

    override func setUpWithError() throws {
        controller = OverviewControllerMock()
        delegate = OverviewDelegateMock()
        
        presenter = OverviewPresenter(controller: controller,
                                      delegate: delegate)
        
        wordPairMocked = [WordsData(text_eng: "hello", text_spa: "bye"),
                          WordsData(text_eng: "welcome", text_spa: "nia"),
                          WordsData(text_eng: "test", text_spa: "luy"),
                          WordsData(text_eng: "sun", text_spa: "shine")]
    }

    override func tearDownWithError() throws {
        controller = nil
        delegate = nil
        presenter = nil
    }

    func testValidateIfWordIsCorrect() {
        sections = OverviewFormatter.convert(wordPairMocked ?? [])
        presenter.sections = sections
        
        if let findIndex = self.findContentIndex() {
            let content = self.sections[findIndex]
            
            if case let .content(model) = content {
                presenter.validateCorrect(word: model.first!)
                
                XCTAssertEqual(model.first?.isCorrect, true)
            }
        }
    }
    
    func testValidateIfWordIsIncorrect() {
        sections = OverviewFormatter.convert(wordPairMocked ?? [])
        presenter.sections = sections
        
        if let findIndex = self.findContentIndex() {
            let content = self.sections[findIndex]
            
            if case let .content(model) = content {
                presenter.validateIncorrect(word: model.first!)
                
                XCTAssertEqual(!model.first!.isCorrect, false)
            }
        }
    }
    
    func findContentIndex() -> Int? {
        return sections.firstIndex { (section) -> Bool in
            guard case .content = section else { return false }
            return true
        }
    }
    
    // MARK: - Controller mocked
    func testIfReloadedCalled() {
        presenter.viewDidLoad()
        XCTAssertTrue(controller.isReloaded)
    }
    
    func testIsCorrectIncreased() {
        presenter.validateCorrect(word: WordPairUIModel(wordEnglish: ContentUIModels(id: 1, word: "spa"),
                                                        wordSpanish: ContentUIModels(id: 1, word: "trw"),
                                                                                     isCorrect: true))
        XCTAssertTrue(controller.isCorrectIncreased)
    }
    
    func testIsIncorrectIncreased() {
        presenter.validateCorrect(word: WordPairUIModel(wordEnglish: ContentUIModels(id: 1, word: "spa"),
                                                        wordSpanish: ContentUIModels(id: 1, word: "swq"),
                                                                                     isCorrect: false))
        XCTAssertTrue(controller.isIncorrectIncreased)
    }
}

// MARK: - Private extensions/methods
private extension OverviewPresenter {
    func findContentIndex() -> Int? {
        return sections.firstIndex { (section) -> Bool in
            guard case .content = section else { return false }
            return true
        }
    }
}
