//
//  Extensions.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

// MARK: - ReSwift
extension Action {
    func dispatchFromMain() {
        DispatchQueue.main.async {
            store.dispatch(self)
        }
    }
}
