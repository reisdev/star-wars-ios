//
//  HomeView.swift
//  StarWarsDeck
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
        static let contentSpacing = 16.0
        static let imageSize = 105
        static let buttonHeight = 80.0
        static let collectionViewInset = 64
    }
    
    // MARK: Views
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star-wars-logo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let shortcutsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 24.0, height: Metrics.buttonHeight)
        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeShortcutViewCell.self, forCellWithReuseIdentifier: String(describing: HomeShortcutViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
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
            make.top.equalTo(self.snp.top).inset(Metrics.logoTopMargin)
            make.centerX.equalToSuperview()
            make.size.equalTo(Metrics.imageSize)
        }
        
        shortcutsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Metrics.contentSpacing)
            make.leading.trailing.equalToSuperview().inset(Metrics.contentSpacing)
            make.bottom.equalToSuperview().inset(Metrics.contentSpacing)
        }
    }
    
    internal func setupStyle() {
        shortcutsCollectionView.delegate = self
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-Metrics.contentSpacing)/2 , height: Metrics.buttonHeight)
    }
}
