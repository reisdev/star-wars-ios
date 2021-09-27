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
    
    private let disposeBag = DisposeBag()
    let soundTrackURL = "https://ia600304.us.archive.org/30/items/StarWarsTheImperialMarchDarthVadersTheme/Star%20Wars-%20The%20Imperial%20March%20%28Darth%20Vader%27s%20Theme%29.mp3"
    
    private var viewModel: OpeningCrawlingViewModel =  OpeningCrawlingViewModel("")
    private var player: AVPlayer!;
    
    convenience init(viewModel: OpeningCrawlingViewModel) {
        self.init()
        self.viewModel = viewModel
        
        setupBindings()
    }
    
    override func loadView() {
        self.view = OpeningCrawlingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            print("AVAudioSession Category Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("AVAudioSession is Active")
            let playerItem = AVPlayerItem(url: URL.init(string: soundTrackURL)!)
            player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.
        /* self.textContainer.layer.transform = CATransform3DRotate(self.textContainer.layer.transform,CGFloat.pi/3,1,0,0) */
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player.play()
        
        customView.animateScroll {
            self.player.pause()
        }
    }
    
}
