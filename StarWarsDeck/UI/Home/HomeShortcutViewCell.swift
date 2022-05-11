//
//  HomeShortcutViewCell.swift
//  StarWarsDeck
//
//  Created by Matheus dos Reis de Jesus on 24/12/21.
//

import Foundation
import UIKit
import RxSwift

final class HomeShortcutViewCell: UICollectionViewCell {
    
    // MARK: Constants
    private struct Metrics {
        static let verticalSpacing: CGFloat = 10
        static let horizontalSpacing: CGFloat = 16
        static let radius: CGFloat = 16
        static let size: CGFloat = 36
    }
    
    // MARK: Properties
    private var isLoading = BehaviorSubject<Bool>(value: false)
    private var disposeBag = DisposeBag()
    
    // MARK: Views
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = Metrics.verticalSpacing
        return stack
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with data: HomeShortcut) {
        iconImageView.image = data.icon
        titleLabel.text = data.title
    }
    
    public func setLoading(with isLoading: Bool) {
        self.isLoading.onNext(isLoading)
    }
}

extension HomeShortcutViewCell: ViewCode {
    internal func buildViewHierarchy() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(loadingView)
        
        addSubview(stackView)
    }
    
    internal func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Metrics.verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(Metrics.horizontalSpacing)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(Metrics.size)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .systemYellow
        layer.cornerRadius = Metrics.radius
        
        isLoading
            .bind(to: iconImageView.rx.isHidden, titleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        isLoading
            .map { !$0 }
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        isLoading.subscribe(onNext: { loading in
            if loading {
                self.loadingView.startAnimating()
            } else {
                self.loadingView.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
}
