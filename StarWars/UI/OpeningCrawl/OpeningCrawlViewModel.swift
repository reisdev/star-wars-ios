//
//  OpeningCrawlViewModel.swift
//  StarWars
//
//  Created by ReisDev on 11/07/21.
//

import Foundation
import RxCocoa

class OpeningCrawlViewModel {
    let crawlingText = BehaviorRelay<String>(value: "")

    init(_ text: String){
        crawlingText.accept(text)
    }
}
