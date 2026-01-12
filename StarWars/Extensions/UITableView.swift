//
//  UITableView.swift
//  StarWars
//
//  Created by Matheus Reis on 12/01/2026.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
