//
//  EntryCollectionViewCell.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit

class EntryCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    private let borderView = BorderedView()
    let numberLabel = UILabel()
    let characterLabel = UILabel()
    let keywordLabel = UILabel()

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
        numberLabel.text = nil
        characterLabel.text = nil
        keywordLabel.text = nil
    }

    // MARK: - UI Setup
    private func configureSubviews() {

        //Content
        contentView.backgroundColor = .systemGray6

        //Border view
        borderView.radiusMultiplier = 16
        borderView.borderWidth = 1
        borderView.borderColor = .systemGray
        borderView.backgroundColor = .white
        contentView.addSubview(borderView)

        //Number label
        numberLabel.font = UIFont.systemFont(ofSize: 13)
        numberLabel.textColor = .lightGray
        contentView.addSubview(numberLabel)

        //Character label
        characterLabel.font = UIFont.boldSystemFont(ofSize: 40)
        characterLabel.textAlignment = .center
        contentView.addSubview(characterLabel)

        //Keyword label
        keywordLabel.font = UIFont.systemFont(ofSize: 17)
        keywordLabel.textAlignment = .center
        contentView.addSubview(keywordLabel)
    }

    private func configureSubviewsLayout() {
        let borderPadding: CGFloat = 2
        let labelPadding: CGFloat = 4

        //Border view
        borderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderView.topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: borderPadding),
            borderView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -borderPadding),
            borderView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: borderPadding),
            borderView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -borderPadding)
        ])

        //Number label
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.topAnchor
                .constraint(equalTo: borderView.topAnchor,
                            constant: labelPadding),
            numberLabel.leadingAnchor
                .constraint(equalTo: borderView.leadingAnchor,
                            constant: labelPadding)
        ])

        //Character label
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterLabel.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor),
            characterLabel.centerXAnchor
                .constraint(equalTo: contentView.centerXAnchor)
        ])

        //Keyword label
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keywordLabel.bottomAnchor
                .constraint(equalTo: borderView.bottomAnchor,
                            constant: -labelPadding),
            keywordLabel.leadingAnchor
                .constraint(equalTo: borderView.leadingAnchor,
                            constant: labelPadding),
            keywordLabel.trailingAnchor
                .constraint(equalTo: borderView.trailingAnchor,
                            constant: -labelPadding)
        ])
    }
}
