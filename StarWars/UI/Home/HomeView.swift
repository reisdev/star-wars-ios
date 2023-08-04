//
//  HomeView.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation
import UIKit
import SnapKit

final class HomeView: UIView {
    
    // MARK: Constants
    private struct Metrics {
        static let logoTopMargin = 50
        static let contentSpacing = 16
        static let imageHeight = 150
        static let buttonSize = 105
        static let collectionViewInset = 64
    }
    
    // MARK: Views
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star-wars-logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let shortcutsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Metrics.buttonSize, height: Metrics.buttonSize)
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeShortcutViewCell.self, forCellWithReuseIdentifier: String(describing: HomeShortcutViewCell.self))
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    convenience init() {
        self.init(frame: .zero)
        setup()
    }
}

extension HomeView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(logoImageView)
        addSubview(shortcutsCollectionView)
    }
    
    internal func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.centerX.equalToSuperview()
            make.height.equalTo(Metrics.imageHeight)
        }
        
        shortcutsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Metrics.contentSpacing)
            make.leading.trailing.equalToSuperview().inset(Metrics.contentSpacing)
            make.bottom.equalToSuperview().inset(Metrics.contentSpacing)
        }
    }
}

