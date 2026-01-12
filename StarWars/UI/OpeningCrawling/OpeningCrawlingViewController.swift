//
//  OpeningCrawlingViewController.swift
//  StarWars
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import RxSwift
import AVFoundation

final class OpeningCrawlingViewController: UIViewController {
    
    private lazy var openingCrawlingView = OpeningCrawlingView()

    private let viewModel: OpeningCrawlingViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var player = AVPlayer()
    private lazy var audioSession = AVAudioSession()
    private let soundtrackURL = Bundle.main.url(
        forResource: "the-imperial-march",
        withExtension: "mp3"
    )

    init(viewModel: OpeningCrawlingViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = openingCrawlingView
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        loadThemeSong()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player.play()
        
        openingCrawlingView.animateScroll { [weak self] in
            self?.player.pause()
        }
    }
    
    private func setupBindings() {
        viewModel.crawlingText
            .bind(to: openingCrawlingView.crawlingText.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.crawlingText
            .map { $0.count == 0 }
            .bind(to: openingCrawlingView.crawlingText.rx.isHidden)
            .disposed(by: disposeBag)
            
        viewModel.crawlingText.subscribe { [weak self] _ in
            self?.openingCrawlingView.scrollToTop()
        }.disposed(by: disposeBag)
    }
    
    // MARK: Actions
    private func loadThemeSong() {
        guard let soundtrackURL else { return }

        do {
            try audioSession.setCategory(.ambient)
            let playerItem = AVPlayerItem(url: soundtrackURL)
            player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
