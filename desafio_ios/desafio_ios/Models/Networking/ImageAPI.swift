//
//  ImageAPI.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import Alamofire

class ImageAPI {
    
    var manager: RequestManager
    var task: DataRequest?
    
    init(manager: RequestManager) {
        self.manager = manager
    }
        
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = manager.request(url: url, method: .get, parameters: [:], headers: [:]) { (response) in
            switch response {
            case let .success(data):
                completion(UIImage(data: data))
            case .failure(_):
                break
            }
        }
        self.task = task
    }
    
    func stopRequest(by url: URL) {
        manager.cancelTask(byUrl: url)
    }
}
