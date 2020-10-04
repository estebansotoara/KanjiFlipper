//
//  BaseViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: ViewModel?

    // MARK: - Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        viewModel = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitle()
    }

    // MARK: - Configuration
    private func configureTitle() {
        if let _ = navigationController {
            navigationItem.title = viewModel?.viewTitle
        } else {
            title = viewModel?.viewTitle
        }
    }
}
