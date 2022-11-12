//
//  MainTranslationCell.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import UIKit

class MainTranslationCell: UITableViewCell {

    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func set(data: WordPairUIModel) {
        topLabel.text = data.wordEnglish.word
        bottomLabel.text = data.wordSpanish.word
    }
}

// MARK: - Private extensions/methods
private extension MainTranslationCell {
    func configureUI() {
        topLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topLabel.textColor = .babbelColor
        
        bottomLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        topLabel.textColor = .black
    }
}
