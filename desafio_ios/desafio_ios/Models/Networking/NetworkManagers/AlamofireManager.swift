//
//  AlamofireManager.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

class AlamofireManager: RequestManager {
    func request(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void) -> DataRequest {
        
        let request = AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(ServiceError.apiError))
            }
        }
        return request
    }
    
    func cancelTask(byUrl url:URL) {
        AF.session.getAllTasks{sessionTasks in
            for task in sessionTasks {
                if task.originalRequest?.url == url {
                    task.cancel()
                }
            }

        }
    }
}
