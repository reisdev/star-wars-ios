//
//  OpeningCrawlingView.swift
//  StarWars
//
//  Created by ReisDev on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class OpeningCrawlingView: UIView {
    
    // MARK: Views
    lazy var crawlingText: UILabel = .make {
        $0.textAlignment = .center
        $0.backgroundColor = .darkGray
        $0.textColor = .systemYellow
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont(name: "Hiragino Sans W7", size: 30.0)
    }
    
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    
    // MARK: Init
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func animateScroll(completion: @escaping () -> ()) {
        UIView.animate(
            withDuration: 45.0,
            delay: 2,
            options: [.allowUserInteraction]
        ) {
            self.scrollView.contentOffset.y = self.contentView.frame.height + 16.0
        } completion: { completed in
            completion()
        }
    }
    
    public func scrollToTop() {
        scrollView.contentOffset.y = 0.0
    }
}

// MARK: ViewCode
extension OpeningCrawlingView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(crawlingText)
    }
    
    internal func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        crawlingText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8.0)
            make.top.bottom.equalToSuperview().inset(8.0)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .darkGray
    }
}
