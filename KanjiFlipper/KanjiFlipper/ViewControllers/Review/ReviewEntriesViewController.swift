//
//  ReviewEntriesViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit
import Combine

class ReviewEntriesViewController: BaseViewController {
    typealias DataSource =
        UICollectionViewDiffableDataSource<ReviewEntriesSection, ReviewEntriesSectionItem>
    typealias Snapshot =
        NSDiffableDataSourceSnapshot<ReviewEntriesSection, ReviewEntriesSectionItem>

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(
            appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout
            .list(using: config)
        return UICollectionView(frame: .zero,
                                collectionViewLayout: layout)
    }()
    private let startReviewSessionButton = BorderedButton()

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let viewModel: ReviewEntriesViewModel
    private var dataSource: DataSource?

    // MARK: - Initializers
    init(viewModel: ReviewEntriesViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)

        self.tabBarItem = UITabBarItem(
            title: ReviewString.review.localized,
            image: IconAsset.pencil.systemImage,
            selectedImage: IconAsset.pencilAndOutline.systemImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        configureSubviewsLayout()

        configureDataSource()
    }

    // MARK: - Configuration
    private func configureDataSource() {

        let dataSource = DataSource(
            collectionView: collectionView) { [weak self]
            (collectionView, indexPath, item) -> UICollectionViewCell? in

            let cell: ReviewDeckInfoCollectionViewCell = collectionView
                .dequeueReusableCell(for: indexPath)
            switch item {
            case .cardsOnDeck:
                self?.configure(cardsOnDeck: item,
                                onCell: cell)
            case .dueCards:
                self?.configure(dueCards: item,
                                onCell: cell)
            case .cardsReviewedToday:
                self?.configure(cardsReviewedToday: item,
                                onCell: cell)
            }
            return cell
        }

        self.dataSource = dataSource
        collectionView.dataSource = dataSource

        viewModel.sectionsPublisher
            .receive(on: DispatchQueue.main)
            .sink { (sections) in
                print("ReviewEntriesViewController: sectionsPublisher sink: \(sections)")

                var snapshot = Snapshot()
                for section in sections {
                    snapshot.appendSections([section.model])
                    snapshot.appendItems(section.items,
                                         toSection: section.model)
                }
                dataSource.apply(snapshot,
                                 animatingDifferences: true)
            }
            .store(in: &cancellableBag)
    }

    // MARK: - Cell configuration
    private func configure(
        cardsOnDeck item: ReviewEntriesSectionItem,
        onCell cell: ReviewDeckInfoCollectionViewCell) {

        cell.titleLabel.text = item.description
        viewModel.cardsOnDeckPublisher
            .sink(receiveValue: { [weak cell] in
                cell?.accesoryLabel.text = $0
            })
            .store(in: &cell.cancellableBag)
    }

    private func configure(
        dueCards item: ReviewEntriesSectionItem,
        onCell  cell: ReviewDeckInfoCollectionViewCell) {

        cell.titleLabel.text = item.description
        viewModel.dueCardsPublisher
            .sink(receiveValue: { [weak cell] in
                cell?.accesoryLabel.text = $0
            })
            .store(in: &cell.cancellableBag)
    }

    private func configure(
        cardsReviewedToday item: ReviewEntriesSectionItem,
        onCell  cell: ReviewDeckInfoCollectionViewCell) {

        cell.titleLabel.text = item.description
        viewModel.cardsReviewedTodayPublisher
            .sink(receiveValue: { [weak cell] in
                cell?.accesoryLabel.text = $0
            })
            .store(in: &cell.cancellableBag)
    }

    // MARK: - UI Configuration
    private func configureSubviews() {

        //View
        view.backgroundColor = .systemGray6

        //Collection view
        collectionView.register(
            cell: ReviewDeckInfoCollectionViewCell.self)

        collectionView.backgroundColor = .systemGray6
        view.addSubview(collectionView)

        //Action button
        let buttonTitle = viewModel.startReviewSessionActionTitle.capitalized
        startReviewSessionButton.radiusMultiplier = 16
        startReviewSessionButton.isExclusiveTouch = true
        startReviewSessionButton.setTitle(buttonTitle,
                                          for: .normal)
        startReviewSessionButton
            .addAction(UIAction(handler: { [weak viewModel] (_) in
                viewModel?.startReviewSession()
            }),
            for: .touchUpInside)
        startReviewSessionButton.backgroundColor = .systemBlue
        view.addSubview(startReviewSessionButton)
    }

    private func configureSubviewsLayout() {
        let vPadding: CGFloat = 16
        let hPadding: CGFloat = 30
        let actionButtonHeight: CGFloat = 50

        //Collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor
                .constraint(equalTo: startReviewSessionButton.topAnchor,
                            constant: -vPadding),
            collectionView.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        //Action button
        startReviewSessionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startReviewSessionButton.heightAnchor
                .constraint(equalToConstant: actionButtonHeight),
            startReviewSessionButton.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                            constant: -vPadding),
            startReviewSessionButton.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                            constant: hPadding),
            startReviewSessionButton.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                            constant: -hPadding)
        ])
    }
}
