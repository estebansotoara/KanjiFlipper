//
//  BaseViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let viewModel: ViewModel

    // MARK: - Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        viewModel.viewTitle
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (title) in
                if let _ = self?.navigationController {
                    self?.navigationItem.title = title
                } else {
                    self?.title = title
                }
            })
            .store(in: &cancellableBag)
    }
}
