//
//  RequestManager.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

protocol RequestManager {
    @discardableResult
    func request(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void) -> DataRequest
    
    func cancelTask(byUrl url:URL) -> Void
}

enum Parameters {
    case startDate
    case endDate
    
    var value: String {
        switch self {
        case .startDate:
            return "start_date"
        case .endDate:
            return "end_date"
        }
    }
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

