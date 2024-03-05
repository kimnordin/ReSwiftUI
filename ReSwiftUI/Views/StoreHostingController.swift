//
//  StoreHostingController.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import ReSwift
import SwiftUI

/**
 Determines whether to skip state updates based on the comparison of the old state and the new state, similar to the official `.skipRepeats` of ReSwift.
 - parameter oldState: The previous state.
 - parameter newState: The new state.
 - returns: `true` if the update should be skipped based on the provided logic, otherwise `false`.
 */
typealias SkipRepeats<State> = (State, State) -> Bool

/**
 A protocol to be implemented by SwiftUI Views that wish to receive state changes and skip certain state updates.
 */
protocol StateViewProtocol {
    func newState(state: RootState)
    var skipRepeatsClosure: SkipRepeats<RootState>? { get }
}

/**
 A Hosting Controller for SwiftUI Views that integrates with ReSwift.
 The controller subscribes to state updates and optionally skip updates based on some logic provided by the hosted SwiftUI View.
 */
class StoreHostingController<Content: View & StateViewProtocol>: UIHostingController<AnyView> {
    var store: Store<RootState>!
    private var storeObject: ObservableState<RootState>!

    init(store: Store<RootState>, rootView: Content) {
        self.store = store
        self.storeObject = ObservableState(initialState: initialRootState(), skipRepeatsClosure: rootView.skipRepeatsClosure)
        let rootViewWithEnvironment = AnyView(rootView.environmentObject(storeObject))
        super.init(rootView: rootViewWithEnvironment)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(storeObject)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(storeObject)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
