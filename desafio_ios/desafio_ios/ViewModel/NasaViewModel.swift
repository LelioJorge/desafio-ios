//
//  NasaViewModel.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation
import UIKit

class NasaViewModel {
    
    private var manager: RequestManager
    private let imageCache = NSCache<NSString, UIImage>()
    private let nasaCache = NSCache<NSString, Nasa>()
    
    lazy var nasaAPI: NasaAPI = {
        NasaAPI(manager: manager)
    }()
    
    lazy var imageAPI: ImageAPI = {
        ImageAPI(manager: manager)
    }()
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func loadImage(title: String) -> UIImage {
        
    }
    
    func loadTitle() -> String {
        
    }
}
