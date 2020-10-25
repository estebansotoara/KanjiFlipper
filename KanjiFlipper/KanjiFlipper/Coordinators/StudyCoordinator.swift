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
        let viewModel = StudyEntryListViewModel()
        viewModel.set(delegate: self)
        let viewController = StudyEntryListViewController(
            viewModel: viewModel)
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

// MARK: - Initializers
extension StudyCoordinator: StudyEntryListViewModelDelegate {
    func studyEntryListViewModel(
        _ viewModel: StudyEntryListViewModel,
        showDetails detailsViewModel: StudyEntryDetailsViewModel) {
        print("StudyCoordinator: studyEntryListViewModel showDetails")
        
        let viewController = StudyEntryDetailsViewController(
            viewModel: detailsViewModel)
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}
