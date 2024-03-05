//
//  NumberReducer.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

func numberReducer(action: Action, state: NumberState?) -> NumberState {
    var state = state ?? initialNumberState()

    switch action {
    case is IncrementNumber:
        state.number += 1
    case is DecreaseNumber:
        state.number -= 1
    case let action as UpdateNumber:
        state.number = action.number
    default: break
    }

    return state
}

func initialNumberState() -> NumberState {
    return NumberState(number: 0)
}
