//
//  OpeningCrawlingViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 11/07/21.
//

import Foundation
import RxSwift

class OpeningCrawlingViewModel {
    let crawlingText = BehaviorSubject<String>(value: "")
    
    init(_ text: String){
        crawlingText.onNext(text)
    }
}
