//
//  OverviewControllerMock.swift
//  jboisjoli-babbelTests
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation
@testable import jboisjoli_babbel

class OverviewControllerMock: OverviewControllerProtocol {
    var isReloaded = false
    var isCorrectIncreased = false
    var isIncorrectIncreased = false
    
    var presenter: OverviewPresenterProtocol?
    
    func updateSections(sections: [OverviewSection], reload: Bool) {
        isReloaded = true
    }
    
    func correctIncrease() {
        isCorrectIncreased = true
    }
    
    func incorrectIncrease() {
        isIncorrectIncreased = true
    }
}
