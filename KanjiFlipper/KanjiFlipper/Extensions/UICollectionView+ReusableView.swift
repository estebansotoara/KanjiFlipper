//
//  UICollectionView+ReusableView.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit

extension UICollectionReusableView: ReusableView {}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionReusableView>(
        supplementaryView: T.Type,
        ofKind elementKind: String) {
        register(T.self,
                 forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
                withReuseIdentifier: T.reuseIdentifier,
                for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier \(T.reuseIdentifier) for indexPath \(indexPath)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String,
        for indexPath: IndexPath) -> T {

        guard let view = dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: T.reuseIdentifier,
                for: indexPath) as? T else {
            fatalError("Could not dequeue reusable view with identifier \(T.reuseIdentifier) for indexPath \(indexPath)")
        }
        return view
    }
}
