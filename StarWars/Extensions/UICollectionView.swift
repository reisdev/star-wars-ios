//
//  UICollectionView.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}
