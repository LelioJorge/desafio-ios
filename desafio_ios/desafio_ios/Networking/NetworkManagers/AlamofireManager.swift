//
//  AlamofireManager.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

class AlamofireManager: RequestManager {
    func request(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void) -> Void {
        
        AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(ServiceError.apiError))
            }
        }
    }
}
