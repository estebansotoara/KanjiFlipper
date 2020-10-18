//
//  StudyCoordinator.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/10/20.
//

import UIKit

final class StudyCoordinator: Coordinator {

    // MARK: - Properties
    var rootViewController: UIViewController {
        navigationController
    }
    private let navigationController = UINavigationController()

    // MARK: - Initializers
    init() {}

    // MARK: - Utils
    func start() {
        let viewController = UIViewController()
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}
