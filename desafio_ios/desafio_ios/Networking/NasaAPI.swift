//
//  NasaAPI.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

class NasaAPI {
    
    var manager: RequestManager
    let url: URL = URL(string: "https://api.nasa.gov/planetary/apod?api_key=7pxN7UvwbOYkly3y2Qed45Izuo0J5iqZOKXQA6Hp")!
    
    init(manager: RequestManager) {
        self.manager = manager
    }
        
    func getNasa(handler: @escaping (Nasa) -> Void, completion: @escaping (Error) -> Void) {
        manager.request(url: url, method: .get, parameters: [:], headers: [:]) { (response) in
            switch response {
            case let .success(data):
                let nasa = try! JSONDecoder().decode(Nasa.self, from: data)
                handler(nasa)
            case let .failure(error):
                completion(error)
            }
        }
    }
}
