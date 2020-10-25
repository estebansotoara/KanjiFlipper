//
//  StudyEntryListViewController.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import UIKit
import Combine

class StudyEntryListViewController: BaseViewController {
    typealias DataSource =
        UICollectionViewDiffableDataSource<StudyEntryListSection, StudyEntryListItem>
    typealias Snapshot =
        NSDiffableDataSourceSnapshot<StudyEntryListSection, StudyEntryListItem>
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: self.compositionalLayout)
    }()
    
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemsPerRow = 3
        let inset: CGFloat = 2
        let spacing = NSCollectionLayoutSpacing.fixed(inset)
        
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: itemsPerRow)
        
        //Header
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(44))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        headerItem.pinToVisibleBounds = true
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        
        //Configuration
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = inset
        
        return UICollectionViewCompositionalLayout(section: section,
                                                   configuration: config)
    }()
    
    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let viewModel: StudyEntryListViewModel
    private var dataSource: DataSource?
    
    // MARK: - Initializers
    init(viewModel: StudyEntryListViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        
        self.tabBarItem = UITabBarItem(
            title: SettingsString.settings.localized,
            image: IconAsset.textBookClosed.systemImage,
            selectedImage: IconAsset.textBookClosedFill.systemImage)
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
            
            let cell: EntryCollectionViewCell = collectionView
                .dequeueReusableCell(for: indexPath)
            cell.numberLabel.text = item.entry.rtkNumber
            cell.characterLabel.text = item.entry.character
            cell.keywordLabel.text = item.entry.keyword
            return cell
        }
        
        dataSource.supplementaryViewProvider = { [weak self]
            (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            guard kind == UICollectionView.elementKindSectionHeader,
                  let section = self?.dataSource?.snapshot()
                    .sectionIdentifiers[indexPath.section] else {
                return nil
            }
            
            let header: EntryListCollectionHeaderView = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    for: indexPath)
            header.titleLabel.text = "Lesson: \(section.lessonNumber)"
            return header
        }
        
        self.dataSource = dataSource
        collectionView.dataSource = dataSource
        
        viewModel.sectionsPublisher
            .receive(on: DispatchQueue.main)
            .sink { (sections) in
                print("StudyEntryListViewController: sectionsPublisher sink: \(sections.count)")
                
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
    
    // MARK: - UI Configuration
    private func configureSubviews() {
        
        //view
        view.backgroundColor = .systemGray6
        
        //collection view
        collectionView.register(
            cell: EntryCollectionViewCell.self)
        collectionView.register(
            supplementaryView: EntryListCollectionHeaderView.self,
            ofKind: UICollectionView.elementKindSectionHeader)
        
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

extension StudyEntryListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        viewModel.selectItem(item)
    }
}
