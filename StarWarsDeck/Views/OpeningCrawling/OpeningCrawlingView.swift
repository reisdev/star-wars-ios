//
//  OpeningCrawlingView.swift
//  StarWarsDeck
//
//  Created by ReisDev on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class OpeningCrawlingView: UIView {
    
    // MARK: Views
    lazy var crawlingText: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .systemYellow
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Hiragino Sans W7", size: CGFloat(30.0))
        return label
    }()
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    
    // - MARK: Init
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func animateScroll(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 45.0, delay: 2, animations: {
            self.scrollView.contentOffset.y = self.contentView.frame.height + 16.0
        }, completion: { completed in
            completion()
        })
    }
    
    public func scrollToTop() {
        self.scrollView.contentOffset.y = 0.0
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
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
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
        backgroundColor = .black
    }
}
