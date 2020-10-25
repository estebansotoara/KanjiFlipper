//
//  EntryListCollectionHeaderView.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/23/20.
//

import UIKit

class EntryListCollectionHeaderView: UICollectionReusableView {

    // MARK: - UI
    let titleLabel = UILabel()

    // MARK: - Properties

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        configureSubviewsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func prepareForReuse() {
        titleLabel.text = nil
    }

    // MARK: - UI Setup
    private func configureSubviews() {

        //view
        backgroundColor = .systemGray6

        //collection view
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        addSubview(titleLabel)
    }

    private func configureSubviewsLayout() {

        let labelHeight: CGFloat = 22
        let bottomPadding: CGFloat = 6
        let borderPadding: CGFloat = 16
        //Title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor
                .constraint(equalTo: self.topAnchor,
                            constant: borderPadding),
            titleLabel.bottomAnchor
                .constraint(equalTo: self.bottomAnchor,
                            constant: -bottomPadding),
            titleLabel.leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: borderPadding),
            titleLabel.trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
                            constant: -borderPadding),
            titleLabel.heightAnchor
                .constraint(equalToConstant: labelHeight)
        ])
    }
}
