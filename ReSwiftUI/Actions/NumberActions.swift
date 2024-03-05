//
//  NumberActions.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

struct IncrementNumber: Action {}

struct DecreaseNumber: Action {}

struct UpdateNumber: Action {
    let number: Int
}
