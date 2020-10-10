//
//  TabBarCoordinator.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/9/20.
//

import UIKit

protocol TabBarCoordinatorDelegate: class {
    func tabBarCoordinatorDidFinish(
        _ coordinator: TabBarCoordinator)
}

final class TabBarCoordinator: Coordinator {

    // MARK: - Properties
    var rootViewController: UIViewController {
        tabBarController
    }
    private let tabBarController = UITabBarController()
    private var childCoordinators = [String: Coordinator]()

    private weak var delegate: TabBarCoordinatorDelegate?

    // MARK: - Initializers
    init() {}

    deinit {
        removeAllChildren()
        delegate?.tabBarCoordinatorDidFinish(self)
    }

    // MARK: - Utils
    func start() {
        var children = [Coordinator]()
        children.append(makeReviewTab())
        children.append(makeStudyTab())
        children.append(makeSettingsTab())
        configureTabBar(with: children)
    }

    private func configureTabBar(with children: [Coordinator]) {

        let controllers = children.map({ $0.rootViewController })
        tabBarController.setViewControllers(controllers,
                                            animated: true)

        removeAllChildren()
        for child in children {
            childCoordinators[child.typeName] = child
        }
    }

    private func removeAllChildren() {
        childCoordinators.removeAll()
    }

    func set(delegate: TabBarCoordinatorDelegate) {
        self.delegate = delegate
    }

    // MARK: - Factory
    private func makeReviewTab() -> Coordinator {
        let coordinator = ReviewCoordinator()
        coordinator.start()
        return coordinator
    }

    private func makeStudyTab() -> Coordinator {
        let coordinator = StudyCoordinator()
        coordinator.start()
        return coordinator
    }

    private func makeSettingsTab() -> Coordinator {
        let coordinator = SettingsCoordinator()
        coordinator.start()
        return coordinator
    }
}
