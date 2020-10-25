//
//  ReviewDeckInfoCollectionViewCell.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit
import Combine

class ReviewDeckInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    let titleLabel = UILabel()
    let accesoryLabel = UILabel()

    // MARK: - Properties
    var cancellableBag = Set<AnyCancellable>()

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
        cancellableBag = Set<AnyCancellable>()
        titleLabel.text = nil
        accesoryLabel.text = nil
    }

    // MARK: - UI Configuration
    private func configureSubviews() {

        //Content
        contentView.backgroundColor = .white

        //Title label
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(titleLabel)

        //Accesory label
        accesoryLabel.font = UIFont.systemFont(ofSize: 15)
        accesoryLabel.textAlignment = .right
        contentView.addSubview(accesoryLabel)
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
                .constraint(equalTo: accesoryLabel.leadingAnchor,
                            constant: -borderPadding)
        ])

        //Accesory label
        accesoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accesoryLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: borderPadding),
            accesoryLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -borderPadding),
            accesoryLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -borderPadding)
        ])
    }
}
