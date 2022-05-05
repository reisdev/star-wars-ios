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
    
    private let baseURL = "https://swapi.dev/api"
    
    static let shared: APIService = {
        return APIService()
    }()
    
    private func urlForResource(with resource: String) -> String {
        return baseURL + "/" + resource
    }
    
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
    
    func search<T: Codable>(resource: String, search: String) -> Observable<T> {
        return Observable<T>.create { observer in
            let url = self.urlForResource(with: resource)
            let parameters: Parameters = ["search": search]
            let request = AF.request(url, parameters: parameters, encoding: URLEncoding(destination: .queryString))
                .responseDecodable(of: T.self, decoder: JSONDecoder()) { (response) in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
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
