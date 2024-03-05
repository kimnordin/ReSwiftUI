//
//  NavigationReducer.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? initialNavigationState()

    switch action {
    case let action as NavigateTo:
        if state.route != action.destination {
            state.route = action.destination
            state.command = .goForward
        }
    case is NavigateBack: // Goes back one step in the Navigation flow
        if let lastRoute = state.history.popLast() {
            state.route = lastRoute
            state.command = .goBackTo
        }
        if state.history.isEmpty {
            state.route = .first
            state.command = .goBack
        }
    case let action as NavigateBackTo: // Goes back to the desired view in the Navigation flow
        if state.route != action.destination && state.history.contains(action.destination) {
            state.route = action.destination
            state.command = .goBackTo
        }
    default: break
    }

    return state
}

func initialNavigationState() -> NavigationState {
    return NavigationState(command: .goForward, route: .first, history: [RoutingDestination]())
}
