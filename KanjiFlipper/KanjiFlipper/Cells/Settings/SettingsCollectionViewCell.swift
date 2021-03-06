//
//  SettingsCollectionViewCell.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/16/20.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {

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

        //content
        contentView.backgroundColor = .white

        //collection view
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(titleLabel)
    }

    private func configureSubviewsLayout() {
        let borderPadding: CGFloat = 16
        //Title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: borderPadding),
            titleLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -borderPadding),
            titleLabel.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: borderPadding),
            titleLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -borderPadding)
        ])
    }
}
