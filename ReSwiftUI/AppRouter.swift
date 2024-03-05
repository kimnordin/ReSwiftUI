//
//  AppRouter.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import Foundation
import SwiftUI
import ReSwift

final class AppRouter {
    let navigationController: UINavigationController
    var tabBarController: UITabBarController?

    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        store.subscribe(self) { subscription in
            subscription.select { state in state.navigationState }
                .skipRepeats { old, new in
                    return old.route == new.route
                }
        }
    }

    private func pushToHostingController<ContentView: View & StateViewProtocol>(_ view: ContentView) {
        let hostingViewController = StoreHostingController(store: store, rootView: view)
        navigationController.pushViewController(hostingViewController, animated: true)
    }

    func popToViewController(ofClass: AnyClass, animated: Bool) {
        if let viewController = navigationController.viewControllers.filter({ $0.isKind(of: ofClass) }).last {
            navigationController.popToViewController(viewController, animated: animated)
        }
    }
}

// MARK: - StoreSubscriber
extension AppRouter: StoreSubscriber {
    func newState(state: NavigationState) {
        DispatchQueue.main.async { [self] in
            switch state.command {
            case .goForward:
                switch state.route {
                case .first:
                    pushToHostingController(FirstView())
                case .second:
                    pushToHostingController(SecondView())
                }
            case .goBack:
                navigationController.popViewController(animated: true)
            case .goBackTo:
                switch state.route {
                case .first:
                    popToViewController(ofClass: StoreHostingController<FirstView>.self, animated: true)
                case .second:
                    popToViewController(ofClass: StoreHostingController<SecondView>.self, animated: true)
                }
            }
        }
    }
}
