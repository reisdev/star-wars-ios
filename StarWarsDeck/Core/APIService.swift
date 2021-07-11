//
//  APIService.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import Foundation
import Alamofire
import RxSwift

class APIService {
    
    static let shared: APIService = {
        return APIService()
    }()
    
    func get<T: Decodable>(_ url: String) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(url).responseDecodable(of: T.self, decoder: JSONDecoder()) { (response) in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
