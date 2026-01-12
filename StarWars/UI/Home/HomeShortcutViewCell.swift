//
//  HomeShortcutViewCell.swift
//  StarWars
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation
import UIKit
import SnapKit

final class HomeShortcutViewCell: UICollectionViewCell {
    
    // MARK: Constants

    private struct Metrics {
        static let spacing: CGFloat = 16
        static let radius: CGFloat = 8
        static let size: CGFloat = 80
        static let iconSize: CGFloat = 40
    }
    
    // MARK: Views
    
    private lazy var stackView = makeGenericStackView(
        axis: .vertical,
        distribution: .fillProportionally,
        spacing: Metrics.spacing,
        views: [iconImageView, titleLabel]
    )

    private lazy var iconImageView: UIImageView = .make {
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel: UILabel = .make {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var loadingView: UIActivityIndicatorView = .make {
        $0.hidesWhenStopped = true
    }
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with data: HomeShortcut) {
        iconImageView.image = data.iconImage
        titleLabel.text = data.title
    }
}

extension HomeShortcutViewCell: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    internal func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Metrics.spacing)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(Metrics.iconSize)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .systemYellow
        layer.cornerRadius = Metrics.radius
    }
}
