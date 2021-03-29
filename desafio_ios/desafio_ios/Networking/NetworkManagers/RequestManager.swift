//
//  RequestManager.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

protocol RequestManager {
    func request(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void) -> Void
}

enum ServiceError: Error{
    case apiError
    
    var localizedDescription: String{
        switch self {
        case .apiError:
            return "Something went wrong."
            
        }
    }
}

enum HTTPMethods: String {
    case get
    
    var alamofire: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return Alamofire.HTTPMethod.get
        }
    }
}

