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
        let viewController = StudyEntryListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

// MARK: - Initializers
extension StudyCoordinator: StudyEntryListViewModelDelegate {
    func studyEntryListViewModel(_ viewModel: StudyEntryListViewModel,
                                 didSelectEntry entry: Entry) {
        print("StudyCoordinator: studyEntryListViewModel didSelectEntry: \(entry)")
        //TODO: navigate to entry details view
    }
}
