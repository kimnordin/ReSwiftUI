//
//  RootReducer.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

func rootReducer(action: Action, state: RootState?) -> RootState {
    return RootState(navigationState: navigationReducer(action: action, state: state?.navigationState), numberState: numberReducer(action: action, state: state?.numberState))
}
        
func initialRootState() -> RootState {
    return RootState(navigationState: initialNavigationState(), numberState: initialNumberState())
}
