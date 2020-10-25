//
//  StudyEntryDetailsViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit
import Combine

final class StudyEntryDetailsViewController: BaseViewController {

    // MARK: - UI
    private let keywordLabel = UILabel()
    private let characterLabel = UILabel()
    private let rtkNumberTitleLabel = UILabel()
    private let rtkNumberLabel = UILabel()
    private let numberOfStrokesTitleLabel = UILabel()
    private let numberOfStrokesLabel = UILabel()
    //private let hintLabel = UILabel()

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let viewModel: StudyEntryDetailsViewModel

    // MARK: - Initializers
    init(viewModel: StudyEntryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        configureSubviewsLayout()

        configurePublishers()
    }

    // MARK: - Configuration
    private func configurePublishers() {

        viewModel.keywordPublisher
            .sink(receiveValue: { [weak keywordLabel] in
                keywordLabel?.text = $0
            })
            .store(in: &cancellableBag)

        viewModel.characterPublisher
            .sink(receiveValue: { [weak characterLabel] in
                characterLabel?.text = $0
            })
            .store(in: &cancellableBag)

        viewModel.rtkNumberPublisher
            .sink(receiveValue: { [weak rtkNumberLabel] in
                rtkNumberLabel?.text = $0
            })
            .store(in: &cancellableBag)

        viewModel.numberOfStrokesPublisher
            .sink(receiveValue: { [weak numberOfStrokesLabel] in
                numberOfStrokesLabel?.text = $0
            })
            .store(in: &cancellableBag)
    }

    // MARK: - UI Configuration
    private func configureSubviews() {

        //View
        view.backgroundColor = .white

        //Keyword
        keywordLabel.font = UIFont.systemFont(ofSize: 40)
        keywordLabel.textColor = .black
        keywordLabel.numberOfLines = 0
        view.addSubview(keywordLabel)

        //Character
        characterLabel.font = UIFont.boldSystemFont(ofSize: 140)
        characterLabel.textColor = .black
        characterLabel.textAlignment = .center
        view.addSubview(characterLabel)

        //Entry number
        rtkNumberTitleLabel.text = viewModel.rtkNumberTitle
        rtkNumberTitleLabel.font = UIFont.systemFont(ofSize: 15)
        rtkNumberTitleLabel.textColor = .lightGray
        view.addSubview(rtkNumberTitleLabel)

        rtkNumberLabel.font = UIFont.systemFont(ofSize: 17)
        rtkNumberLabel.textColor = .black
        view.addSubview(rtkNumberLabel)

        //Number of strokes
        numberOfStrokesTitleLabel.text = viewModel.numberOfStrokesTitle
        numberOfStrokesTitleLabel.font = UIFont.systemFont(ofSize: 15)
        numberOfStrokesTitleLabel.textColor = .lightGray
        view.addSubview(numberOfStrokesTitleLabel)

        numberOfStrokesLabel.font = UIFont.systemFont(ofSize: 17)
        numberOfStrokesLabel.textColor = .black
        view.addSubview(numberOfStrokesLabel)
    }

    private func configureSubviewsLayout() {
        let vPadding: CGFloat = 50
        let hPadding: CGFloat = 35
        let smallLabelGap: CGFloat = 4

        //Keyword
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keywordLabel.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                            constant: vPadding),
            keywordLabel.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                            constant: hPadding),
            keywordLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                            constant: -hPadding)
        ])

        //Character
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterLabel.topAnchor
                .constraint(equalTo: keywordLabel.bottomAnchor,
                            constant: smallLabelGap),
            characterLabel.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                            constant: -hPadding)
        ])
        characterLabel.setContentCompressionResistancePriority(
            .required, for: .horizontal)

        //Entry number
        rtkNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rtkNumberTitleLabel.topAnchor
                .constraint(equalTo: keywordLabel.bottomAnchor,
                            constant: vPadding/2),
            rtkNumberTitleLabel.leadingAnchor
                .constraint(equalTo: keywordLabel.leadingAnchor),
            rtkNumberTitleLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: characterLabel.leadingAnchor,
                            constant: -smallLabelGap)
        ])

        rtkNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rtkNumberLabel.topAnchor
                .constraint(equalTo: rtkNumberTitleLabel.bottomAnchor,
                            constant: smallLabelGap),
            rtkNumberLabel.leadingAnchor
                .constraint(equalTo: keywordLabel.leadingAnchor),
            rtkNumberLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: characterLabel.leadingAnchor,
                            constant: -smallLabelGap)
        ])

        //Number of strokes
        numberOfStrokesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfStrokesTitleLabel.topAnchor
                .constraint(equalTo: rtkNumberLabel.bottomAnchor,
                            constant: vPadding/2),
            numberOfStrokesTitleLabel.leadingAnchor
                .constraint(equalTo: keywordLabel.leadingAnchor),
            numberOfStrokesTitleLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: characterLabel.leadingAnchor,
                            constant: -smallLabelGap)
        ])

        numberOfStrokesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfStrokesLabel.topAnchor
                .constraint(equalTo: numberOfStrokesTitleLabel.bottomAnchor,
                            constant: smallLabelGap),
            numberOfStrokesLabel.leadingAnchor
                .constraint(equalTo: keywordLabel.leadingAnchor),
            numberOfStrokesLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: characterLabel.leadingAnchor,
                            constant: -smallLabelGap)
        ])
    }
}
