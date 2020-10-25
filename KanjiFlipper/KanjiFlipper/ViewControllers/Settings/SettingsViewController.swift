//
//  SettingsViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/16/20.
//

import UIKit
import Combine

final class SettingsViewController: BaseViewController {
    typealias DataSource =
        UICollectionViewDiffableDataSource<SettingsSection, SettingsSectionItem>
    typealias Snapshot =
        NSDiffableDataSourceSnapshot<SettingsSection, SettingsSectionItem>

    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(
            appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout
            .list(using: config)
        return UICollectionView(frame: .zero,
                                collectionViewLayout: layout)
    }()

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let viewModel: SettingsViewModel
    private var dataSource: DataSource?

    // MARK: - Initializers
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)

        self.tabBarItem = UITabBarItem(
            title: SettingsString.settings.localized,
            image: IconAsset.gearshape.systemImage,
            selectedImage: IconAsset.gearshapeFill.systemImage)
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

        let dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell: SettingsCollectionViewCell = collectionView
                .dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = item.description
            return cell
        }

        self.dataSource = dataSource
        collectionView.dataSource = dataSource

        viewModel.sectionsPublisher
            .receive(on: DispatchQueue.main)
            .sink { (sections) in
                print("SettingsViewController: sectionsPublisher sink: \(sections)")

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

    // MARK: - UI Setup
    private func configureSubviews() {

        //view
        view.backgroundColor = .systemGray6

        //collection view
        collectionView.register(
            cell: SettingsCollectionViewCell.self)

        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func configureSubviewsLayout() {

        //collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension SettingsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        switch item {
        case .resetDataBase:
            viewModel.resetDataBase()
        }
    }
}
