//
//  OpeningCrawlViewController.swift
//  StarWars
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import RxSwift
import AVFoundation

final class OpeningCrawlViewController: UIViewController {
    
    private lazy var openingCrawlView = OpeningCrawlView()

    private let viewModel: OpeningCrawlViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var player = AVPlayer()
    private lazy var audioSession = AVAudioSession()
    private let soundtrackURL = Bundle.main.url(
        forResource: "the-imperial-march",
        withExtension: "mp3"
    )

    init(viewModel: OpeningCrawlViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = openingCrawlView
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.crawlingText
            .bind(to: openingCrawlView.crawlingText.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.crawlingText
            .map { $0.count == 0 }
            .bind(to: openingCrawlView.crawlingText.rx.isHidden)
            .disposed(by: disposeBag)
            
        viewModel.crawlingText.subscribe { [weak self] _ in
            self?.loadThemeSong()
            self?.openingCrawlView.scrollToTop()

            self?.player.play()

            self?.openingCrawlView.animateScroll { [weak self] in
                self?.player.pause()
                self?.player.seek(to: .zero)
            }
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
