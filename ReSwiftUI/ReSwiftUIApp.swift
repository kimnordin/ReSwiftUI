//
//  ReSwiftUIApp.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import SwiftUI
import ReSwift

let store = Store<RootState>(reducer: rootReducer, state: nil, middleware: [])

@main
struct ReSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView() // Initial View is presented through AppRouter in AppDelegate
        }
    }
}
