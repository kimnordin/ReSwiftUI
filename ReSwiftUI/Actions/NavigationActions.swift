//
//  NavigationActions.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

struct NavigateTo: Action {
    let destination: RoutingDestination
}

struct NavigateBack: Action {}

struct NavigateBackTo: Action {
    let destination: RoutingDestination
}
