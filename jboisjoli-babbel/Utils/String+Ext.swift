//
//  String+Ext.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
