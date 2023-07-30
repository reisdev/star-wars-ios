//
//  HomeShortcutViewCell.swift
//  StarWarsDeck
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.spacing
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with data: HomeShortcut) {
        iconImageView.image = data.icon
        titleLabel.text = data.title
    }
}

extension HomeShortcutViewCell: ViewCode {

    internal func buildViewHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    internal func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Metrics.spacing)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(Metrics.iconSize)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .systemYellow
        layer.cornerRadius = Metrics.radius
    }
}
