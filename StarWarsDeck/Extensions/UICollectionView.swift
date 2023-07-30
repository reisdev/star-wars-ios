//
//  UICollectionView.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 27/07/23.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T>(withReuseIdentifier reuseIdentifier: String, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
