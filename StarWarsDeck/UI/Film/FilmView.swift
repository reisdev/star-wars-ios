//
//  FilmView.swift
//  StarWarsDeck
//
//  Created by ReisDev on 11/07/21.
//

import Foundation
import RxSwift
import RxCocoa

final class FilmView: UIView {
    
    // MARK: Layout views
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var verticalStack = makeGenericStackView(axis: .vertical)
    private lazy var directorStack = makeGenericStackView(axis: .horizontal, spacing: 20.0,views: [directorLabel, directorName])
    private lazy var producerStack = makeGenericStackView(axis: .horizontal, views: [producerLabel, producerName])
    private lazy var yearStack = makeGenericStackView(axis: .horizontal, views: [movieYearLabel, movieYear])
    private lazy var firstShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [charactersButton,vehiclesButton])
    private lazy var secondShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [planetsButton,speciesButton])
    private lazy var shortcutsStack = makeGenericStackView(axis: .vertical, views: [firstShortcutLine,secondShortcutLine])
    
    // MARK: Subviews
    lazy var movieCoverImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var directorLabel = makeGenericLabel(text: "Director",fontSize: 20.0,weight: .bold)
    lazy var directorName = makeGenericLabel(fontSize: 18.0)
    lazy var producerLabel = makeGenericLabel(text: "Producer", fontSize: 20.0,weight: .bold)
    lazy var producerName = makeGenericLabel(fontSize: 18.0)
    lazy var movieYearLabel = makeGenericLabel(text: "Year", fontSize: 20.0, weight: .bold)
    lazy var movieYear = makeGenericLabel(fontSize: 18.0)
    lazy var crawlingButton = makeGenericButton(title: "Opening Crawling",image: UIImage(systemName: "play.fill"), rounded: true)
    lazy var charactersButton = makeGenericButton(title: "Characters", image: UIImage(systemName: "person.fill"), rounded: true)
    lazy var vehiclesButton = makeGenericButton(title: "Vehicles", image: UIImage(systemName: "airplane"), rounded: true)
    lazy var planetsButton = makeGenericButton(title: "Planets", image: UIImage(systemName: "globe"), rounded: true)
    lazy var speciesButton = makeGenericButton(title: "Species", image: UIImage(named: "dna"), rounded: true)
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
        setup()
    }
}

// MARK: ViewCode
extension FilmView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [movieCoverImageView, directorStack, producerStack,
         yearStack, crawlingButton, shortcutsStack].forEach {
            verticalStack.addArrangedSubview($0)
         }
        
        contentView.addSubview(verticalStack)
    }
    
    internal func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalToSuperview()
        }
        
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20.0)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .darkGray
    }
}
