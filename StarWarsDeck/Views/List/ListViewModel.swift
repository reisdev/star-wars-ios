//
//  ListViewModel.swift
//  StarWarsDeck
//
//  Created by ReisDev on 09/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    public var urls = BehaviorRelay<[String]>(value: [])
    public var title = BehaviorRelay<String>(value: "List")
    
    init(_ items: [String],_ title: String){
        urls.accept(items)
    }
    
    func getItemByIndex(index: Int) -> String {
        return urls.value[index]
    }
}
