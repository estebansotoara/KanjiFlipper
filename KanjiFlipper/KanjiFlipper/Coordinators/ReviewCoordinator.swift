//
//  ReviewCoordinator.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/10/20.
//

import UIKit

final class ReviewCoordinator: Coordinator {

    // MARK: - Properties
    var rootViewController: UIViewController {
        navigationController
    }
    private let navigationController = UINavigationController()

    // MARK: - Initializers
    init() {}

    // MARK: - Utils
    func start() {
        let viewModel = ReviewEntriesViewModel()
        //viewModel.set(delegate: self)
        let viewController = ReviewEntriesViewController(
            viewModel: viewModel)
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}
