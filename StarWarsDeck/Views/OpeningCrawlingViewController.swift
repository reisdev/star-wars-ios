//
//  OpeningCrawlingViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 25/04/21.
//

import UIKit
import AVFoundation

class OpeningCrawlingViewController: UIViewController {
    
    var soundTrackURL = "https://ia600304.us.archive.org/30/items/StarWarsTheImperialMarchDarthVadersTheme/Star%20Wars-%20The%20Imperial%20March%20%28Darth%20Vader%27s%20Theme%29.mp3"

    public var crawlingText: String = "";
    @IBOutlet var textContainer: UIView!;
    @IBOutlet var scroller: UITextView!;
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /* self.textContainer.layer.transform = CATransform3DRotate(self.textContainer.layer.transform,CGFloat.pi/3,1,0,0) */
        self.scroller.isScrollEnabled = false
        self.scroller.text = self.crawlingText.replacingOccurrences(of: "\r\n", with: "\n", options: .literal, range: nil);
        self.scroller.isScrollEnabled = true
        
        self.scroller.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let scrollHeight = CGFloat(self.scroller.contentSize.height - self.scroller.bounds.size.height)
        
        playSoundTrack()
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
