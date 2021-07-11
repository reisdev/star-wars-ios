//
//  OpeningCrawlingView.swift
//  StarWarsDeck
//
//  Created by mobile2you on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class OpeningCrawlingView: UIView {

    var scrollableText: UITextView = UITextView();
    
    // - MARK: Init
    init(){
        super.init(frame: .zero)
        addViews()
        addConstraints()
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        addConstraints()
        setupView()
    }

    private func addViews() {
        addSubview(scrollableText)
    }
    
    private func addConstraints() {
        scrollableText.snp.makeConstraints({ make in
            make.edges.equalTo(safeAreaLayoutGuide)
        })
    }
    
    private func setupView(){
        scrollableText.textAlignment = .center
        scrollableText.backgroundColor = .black
        scrollableText.textColor = .systemYellow
        scrollableText.font = UIFont(name: "Hiragino Sans W7", size: CGFloat(30.0))
    }

    

}
