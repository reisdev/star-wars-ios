//
//  ListViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift

class ListViewModel {
    public var urls = BehaviorSubject<[String]>(value: [])
    public var title = BehaviorSubject<String>(value: "List")
    
    init(_ items: [String],_ title: String){
        urls.onNext(items)
    }
}
