//
//  AppCoordinator.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/9/20.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties
    private var window: UIWindow
    var rootViewController: UIViewController {
        return window.rootViewController ?? UINavigationController()
    }
    private var childCoordinators = [String: Coordinator]()

    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Utils
    func start() {
        setupTabBar()
        window.makeKeyAndVisible()
    }

    private func setupTabBar() {
        let coordinator = TabBarCoordinator()
        coordinator.set(delegate: self)
        coordinator.start()
        childCoordinators[coordinator.typeName] = coordinator

        window.rootViewController = coordinator.rootViewController
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func tabBarCoordinatorDidFinish(
        _ coordinator: TabBarCoordinator) {
        childCoordinators[coordinator.typeName] = nil
    }
}
