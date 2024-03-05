//
//  NavigationState.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

struct NavigationState: StateType {
    var command: Command
    var route: RoutingDestination
    var history: [RoutingDestination]
}

enum Command {
    case goForward
    case goBack
    case goBackTo
}

enum RoutingDestination: CaseIterable, Equatable {
    case first, second
}
