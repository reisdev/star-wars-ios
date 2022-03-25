//
//  OpeningCrawlingViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

final class OpeningCrawlingViewController: UIViewController {
    
    private unowned var customView: OpeningCrawlingView {
        return view as! OpeningCrawlingView
    }
    
    private let viewModel: OpeningCrawlingViewModel
    private let disposeBag = DisposeBag()
    
    private var player: AVPlayer!
    private let soundTrackURL = "https://ia600304.us.archive.org/30/items/StarWarsTheImperialMarchDarthVadersTheme/Star%20Wars-%20The%20Imperial%20March%20%28Darth%20Vader%27s%20Theme%29.mp3"
    
    init(viewModel: OpeningCrawlingViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = OpeningCrawlingView()
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
        
        customView.animateScroll {
            self.player.pause()
        }
    }
    
    private func setupBindings() {
        viewModel.crawlingText
            .bind(to: customView.crawlingText.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.crawlingText
            .map { $0.count == 0 }
            .bind(to: customView.crawlingText.rx.isHidden)
            .disposed(by: disposeBag)
            
        viewModel.crawlingText.subscribe(onNext: { _ in
            self.customView.scrollToTop()
        }).disposed(by: disposeBag)
    }
    
    // MARK: Actions
    private func loadThemeSong() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
            let playerItem = AVPlayerItem(url: URL.init(string: soundTrackURL)!)
            player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
