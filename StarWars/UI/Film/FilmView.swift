//
//  FilmView.swift
//  StarWars
//
//  Created by ReisDev on 11/07/21.
//

import Foundation
import UIKit

protocol FilmViewDelegate: AnyObject {
    func didTapCharactersButton()
    func didTapSpeciesButton()
    func didTapVehiclesButton()
    func didTapPlanetsButton()
}

final class FilmView: UIView {
    
    // MARK: Layout views
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var verticalStack = makeGenericStackView(
        axis: .vertical,
        views: [
            infoStackView,
            movieCoverImageView,
            directorStack,
            producerStack,
            yearStack,
            crawlingButton,
            shortcutsStack
        ]
    )
    private lazy var infoStackView = makeGenericStackView(axis: .horizontal, views: [backButton, movieTitle,movieYear])
    private lazy var directorStack = makeGenericStackView(axis: .horizontal, spacing: 20.0,views: [directorLabel, directorName])
    private lazy var producerStack = makeGenericStackView(axis: .horizontal, views: [producerLabel, producerName])
    private lazy var yearStack = makeGenericStackView(axis: .horizontal, views: [movieYear])
    private lazy var firstShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [charactersButton,vehiclesButton])
    private lazy var secondShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually, views: [planetsButton,speciesButton])
    private lazy var shortcutsStack = makeGenericStackView(axis: .vertical, views: [firstShortcutLine,secondShortcutLine])
    
    // MARK: Subviews
    lazy var backButton: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(with: .init(style: .icon(.chevronLeft)))
        return button
    }()

    lazy var movieCoverImageView: UIImageView = .make {
        $0.contentMode = .scaleAspectFit
    }
    lazy var movieTitle = makeGenericLabel(fontSize: 26.0,weight: .bold)
    lazy var movieYear = makeGenericLabel(font: UIFont(name: "Hiragino Sans W6", size: 18.0));
    lazy var directorLabel = makeGenericLabel(text: "Director",fontSize: 20.0,weight: .bold);
    lazy var directorName = makeGenericLabel(fontSize: 18.0);
    lazy var producerLabel = makeGenericLabel(text: "Producer", fontSize: 20.0,weight: .bold);
    lazy var producerName = makeGenericLabel(fontSize: 18.0);
    lazy var crawlingButton: Button = {
        let button = Button(props: .init(style: .primary, title: "Opening Crawling", image: .play, rounded: true))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var charactersButton: Button = {
        let button = Button(props: .init(style: .primary, title: "Characters", image: .person, rounded: true))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(title: "Tap") { [weak self] _ in
            self?.delegate?.didTapCharactersButton()
        }, for: .touchUpInside)
        return button
    }()
    
    lazy var vehiclesButton: Button = {
        let button = Button(props: .init(style: .primary, title: "Vehicles", image: .airplane, rounded: true))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(title: "Tap") { [weak self] _ in
            self?.delegate?.didTapVehiclesButton()
        }, for: .touchUpInside)
        return button
    }()
    
    
    lazy var planetsButton: Button = {
        let button = Button(props: .init(style: .primary, title: "Planets", image: .globe, rounded: true))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(title: "Tap") { [weak self] _ in
            self?.delegate?.didTapPlanetsButton()
        }, for: .touchUpInside)
        return button
    }()
    
    lazy var speciesButton: Button = {
        let button = Button(props: .init(style: .primary, title: "Species", image: .dna, rounded: true))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(title: "Tap") { [weak self] _ in
            self?.delegate?.didTapSpeciesButton()
        }, for: .touchUpInside)
        return button
    }()
    
    weak var delegate: FilmViewDelegate?
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
        setup()
    }
    
    func setup(with props: FilmViewProps) {
        movieTitle.text = props.title
        movieYear.text = props.year
        directorName.text = props.director
        producerName.text = props.producer

        movieCoverImageView.image = .init(named: "episode\(props.episodeId)")
    }
}

// MARK: ViewCode
extension FilmView: ViewCode {
    internal func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
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
            make.top.bottom.equalToSuperview().inset(24.0)
            make.left.right.equalToSuperview().inset(24.0)
        }
    }
    
    internal func setupStyle() {
        backgroundColor = .darkGray

        verticalStack.setCustomSpacing(50.0, after: infoStackView)
        verticalStack.setCustomSpacing(30.0, after: producerStack)
    }
}
