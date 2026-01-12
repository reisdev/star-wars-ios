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
        static let buttonSize = 110
        static let collectionViewInset = 64
    }
    
    // MARK: Views
    private lazy var logoImageView: UIImageView = .make {
        $0.image = UIImage(named: "star-wars-logo")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var shortcutsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Metrics.buttonSize, height: Metrics.buttonSize)
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            HomeShortcutViewCell.self,
            forCellWithReuseIdentifier: HomeShortcutViewCell.identifier
        )
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(logoImageView)
        addSubview(shortcutsCollectionView)
    }
    
    internal func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metrics.logoTopMargin)
            make.centerX.equalToSuperview()
            make.height.equalTo(Metrics.imageHeight)
        }
        
        shortcutsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Metrics.contentSpacing)
            make.leading.trailing.equalToSuperview().inset(Metrics.contentSpacing).priority(.low)
            make.bottom.equalToSuperview().inset(Metrics.contentSpacing).priority(.low)
        }
    }

    internal func setupStyle() {
        backgroundColor = .darkGray
    }
}

