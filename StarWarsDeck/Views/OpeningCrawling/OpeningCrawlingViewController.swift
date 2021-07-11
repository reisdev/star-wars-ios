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

class OpeningCrawlingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    let soundTrackURL = "https://ia600304.us.archive.org/30/items/StarWarsTheImperialMarchDarthVadersTheme/Star%20Wars-%20The%20Imperial%20March%20%28Darth%20Vader%27s%20Theme%29.mp3"
    
    private var viewModel: OpeningCrawlingViewModel =  OpeningCrawlingViewModel("")
    
    convenience init(viewModel: OpeningCrawlingViewModel) {
        self.init()
        self.viewModel = viewModel
        self.view = OpeningCrawlingView()
        
        setupBindings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* self.textContainer.layer.transform = CATransform3DRotate(self.textContainer.layer.transform,CGFloat.pi/3,1,0,0) */
    }
    
    private func setupBindings() {
        viewModel.crawlingText
            .bind(to: (view as! OpeningCrawlingView).scrollableText.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.crawlingText.subscribe(onNext: { (text) in
            debugPrint(text)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // playSoundTrack()
                
        // Make auto-scrolling animation
        /*
         UIView.animateKeyframes(withDuration: 25.0, delay: 2, animations: {
         UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
         self.scroller.contentOffset.y = 0.0
         })
         UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 45.0, animations: {
         self.scroller.contentOffset.y = scrollHeight
         })
         })
         */
    }
    
    func playSoundTrack() {
        let playerItem = AVPlayerItem(url: URL.init(string: soundTrackURL)!)
        let sound: AVPlayer = AVPlayer(playerItem: playerItem)
        sound.volume = 1.0
        sound.play()
    }
    
}
