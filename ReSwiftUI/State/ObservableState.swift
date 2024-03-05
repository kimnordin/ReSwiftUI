//
//  ObservableState.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift

/**
 An Observable State that bridges ReSwift State updates to an ObservableObject, so it may be used by SwiftUI Views.
 */
class ObservableState<State>: ObservableObject where State: StateType {
    // The current App State
    @Published var state: State

    // Optional closure for determining whether to skip state updates.
    var skipRepeatsClosure: SkipRepeats<State>?
    private var lastState: State?

    /**
     Initializes a new instance of `ObservableState` with a given initial state.
     - parameter initialState: The initial value for the state.
     - parameter skipRepeatsClosure: Closure determining when to skip state updates.
     */
    init(initialState: State, skipRepeatsClosure: SkipRepeats<State>? = nil) {
        self.state = initialState
        self.skipRepeatsClosure = skipRepeatsClosure
    }
}

extension ObservableState: StoreSubscriber {
    func newState(state: State) {
        DispatchQueue.main.async {
            if let skipRepeatsClosure = self.skipRepeatsClosure,
               let lastState = self.lastState,
               skipRepeatsClosure(lastState, state) {
                return
            }
            self.state = state
            self.lastState = state
        }
    }
}
