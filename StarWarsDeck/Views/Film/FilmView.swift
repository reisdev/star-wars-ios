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
    var contentView = UIView()
    var verticalStack = makeGenericStackView(axis: .vertical)
    var infoStackView = makeGenericStackView(axis: .horizontal)
    var directorStack = makeGenericStackView(axis: .horizontal,spacing: 20.0)
    var producerStack = makeGenericStackView(axis: .horizontal)
    var firstShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually)
    var secondShortcutLine = makeGenericStackView(axis: .horizontal, distribution: .fillEqually)
    var shortcutsStack = makeGenericStackView(axis: .vertical)
    
    // MARK: Subviews
    var movieTitle = makeGenericLabel(fontSize: 26.0,weight: .bold)
    var movieYear = makeGenericLabel(font: UIFont(name: "Hiragino Sans W6", size: 18.0));
    var directorLabel = makeGenericLabel(text: "Director",fontSize: 20.0,weight: .bold);
    var directorName = makeGenericLabel(fontSize: 18.0);
    var producerLabel = makeGenericLabel(text: "Producer", fontSize: 20.0,weight: .bold);
    var producerName = makeGenericLabel(fontSize: 18.0);
    var crawlingButton = makeGenericButton(title: "Opening Crawling",image: UIImage(systemName: "play.fill"));
    var charactersButton = makeGenericButton(title: "Characters", image: UIImage(systemName: "person.fill"));
    var vehiclesButton = makeGenericButton(title: "Vehicles", image: UIImage(systemName: "airplane"))
    var planetsButton = makeGenericButton(title: "Planets", image: UIImage(systemName: "globe"));
    var speciesButton = makeGenericButton(title: "Species", image: UIImage(named: "dna"));
    
    init(){
        super.init(frame: .zero)
        addViews()
        addConstraints()
        setupUI()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    private func addViews() {
        addSubview(contentView)
        
        infoStackView.addArrangedSubview(movieTitle)
        infoStackView.addArrangedSubview(movieYear)
        verticalStack.addArrangedSubview(infoStackView)
        
        directorStack.addArrangedSubview(directorLabel)
        directorStack.addArrangedSubview(directorName)
        verticalStack.addArrangedSubview(directorStack)
        
        producerStack.addArrangedSubview(producerLabel)
        producerStack.addArrangedSubview(producerName)
        verticalStack.addArrangedSubview(producerStack)
        
        verticalStack.addArrangedSubview(crawlingButton)
        
        firstShortcutLine.addArrangedSubview(charactersButton)
        firstShortcutLine.addArrangedSubview(vehiclesButton)
        
        secondShortcutLine.addArrangedSubview(planetsButton)
        secondShortcutLine.addArrangedSubview(speciesButton)
        
        shortcutsStack.addArrangedSubview(firstShortcutLine)
        shortcutsStack.addArrangedSubview(secondShortcutLine)

        verticalStack.addArrangedSubview(shortcutsStack)
        
        contentView.addSubview(verticalStack)
    }
    
    private func addConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
        }
        
        directorStack.snp.makeConstraints { make in
            make.width.equalTo(verticalStack.snp.width)
        }
        
        producerStack.snp.makeConstraints { make in
            make.width.equalTo(verticalStack.snp.width)
        }
        
        shortcutsStack.snp.makeConstraints { make in
            make.width.equalTo(verticalStack.snp.width)
        }
    }
    
    private func setupUI() {
        backgroundColor = .black
        
        verticalStack.setCustomSpacing(30.0, after: infoStackView)
        verticalStack.setCustomSpacing(30.0, after: producerStack)
    }
}
