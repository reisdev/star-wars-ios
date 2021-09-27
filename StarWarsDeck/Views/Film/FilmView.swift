//
//  FilmView.swift
//  StarWarsDeck
//
//  Created by ReisDev on 11/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class FilmView: UIView {
    
    // MARK: Layout views
    private lazy var contentView = UIView()
    private lazy var verticalStack = makeGenericStackView(axis: .vertical, views: [backButton, movieTitle,movieYear])
    private lazy var infoStackView = makeGenericStackView(axis: .horizontal)
    private lazy var directorStack = makeGenericStackView(axis: .horizontal, spacing: 20.0,views: [directorLabel, directorName])
    private lazy var producerStack = makeGenericStackView(axis: .horizontal, views: [producerLabel, producerName])
    private lazy var firstShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [charactersButton,vehiclesButton])
    private lazy var secondShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [planetsButton,speciesButton])
    private lazy var shortcutsStack = makeGenericStackView(axis: .vertical, views: [firstShortcutLine,secondShortcutLine])
    
    // MARK: Subviews
    lazy var backButton = makeGenericButton(image: UIImage(systemName: "chevron.left"),style: .secondary)
    lazy var movieTitle = makeGenericLabel(fontSize: 26.0,weight: .bold)
    lazy var movieYear = makeGenericLabel(font: UIFont(name: "Hiragino Sans W6", size: 18.0));
    lazy var directorLabel = makeGenericLabel(text: "Director",fontSize: 20.0,weight: .bold);
    lazy var directorName = makeGenericLabel(fontSize: 18.0);
    lazy var producerLabel = makeGenericLabel(text: "Producer", fontSize: 20.0,weight: .bold);
    lazy var producerName = makeGenericLabel(fontSize: 18.0);
    lazy var crawlingButton = makeGenericButton(title: "Opening Crawling",image: UIImage(systemName: "play.fill"), rounded: true);
    lazy var charactersButton = makeGenericButton(title: "Characters", image: UIImage(systemName: "person.fill"), rounded: true);
    lazy var vehiclesButton = makeGenericButton(title: "Vehicles", image: UIImage(systemName: "airplane"), rounded: true)
    lazy var planetsButton = makeGenericButton(title: "Planets", image: UIImage(systemName: "globe"), rounded: true);
    lazy var speciesButton = makeGenericButton(title: "Species", image: UIImage(named: "dna"), rounded: true);
    
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
        addSubview(contentView)
        
        [infoStackView,directorStack,producerStack,
         crawlingButton,shortcutsStack].forEach {
            verticalStack.addArrangedSubview($0)
         }
        
        contentView.addSubview(verticalStack)
    }
    
    internal func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(20.0)
            make.right.equalTo(contentView.snp.right).inset(20.0)
        }
        
        directorStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        producerStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        shortcutsStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .black
        
        verticalStack.setCustomSpacing(50.0, after: infoStackView)
        verticalStack.setCustomSpacing(30.0, after: producerStack)
    }
}
