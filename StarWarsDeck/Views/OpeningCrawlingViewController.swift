//
//  OpeningCrawlingViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 25/04/21.
//

import UIKit

class OpeningCrawlingViewController: UIViewController {

    public var crawlingText: String = "";
    @IBOutlet var textContainer: UIView!;
    @IBOutlet var scroller: UITextView!;
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /* self.textContainer.layer.transform = CATransform3DRotate(self.textContainer.layer.transform,CGFloat.pi/3,1,0,0) */
        self.scroller.text = self.crawlingText.replacingOccurrences(of: "\r\n", with: "\n", options: .literal, range: nil) ;
        
        UIView.animate(withDuration: 30.0, animations: {
            self.scroller.scrollRangeToVisible(NSRange(location: self.crawlingText.count - 1, length:1))
            self.scroller.layoutIfNeeded()
        })
        
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
