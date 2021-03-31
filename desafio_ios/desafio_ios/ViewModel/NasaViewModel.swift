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
    private var startDate: Date = Date()
    private var endDate: Date = Date()
    private var finalyDate: Date = Date()
    private var dispathGroup = DispatchGroup()
    private var monthCurrent: Int = 1
    
    lazy var nasaAPI: NasaAPI = {
        NasaAPI(manager: manager)
    }()
    
    lazy var imageAPI: ImageAPI = {
        ImageAPI(manager: manager)
    }()
    
    init(manager: RequestManager) {
        self.manager = manager
        self.startDate = getDateFor(month: -(monthCurrent + 1))!
        self.endDate = getDateFor(month: -monthCurrent)!
        self.finalyDate = getDateFor(month: -308)!
        
    }
    

    
    func getImage(nasa: Nasa, index: Int, completion: @escaping (UIImage) -> Void) -> Void {
        
        guard let image = imageCache.object(forKey: String(index) as NSString) else {
            guard let url = URL(string: nasa.url) else { return }
            dispathGroup.enter()
            imageAPI.getImage(url: url) { [self] (image) in
                defer { dispathGroup.leave() }
                guard let image = image else { return }
                imageCache.setObject(image, forKey: String(index) as NSString as NSString)
                completion(image)
            }
       
            return
        }
        
        completion(image)
    }
    
     func getNasa(completion: @escaping ([Nasa]) -> Void) {
//        dispathGroup.enter()
 
        if startDate < finalyDate {
            resetDate()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(startDate)
        print(endDate)
        print(dateFormatter.string(from: startDate))
        print(dateFormatter.string(from: endDate))
        

        
        let parameters = [Parameters.startDate.value: dateFormatter.string(from: startDate),
                          Parameters.endDate.value : dateFormatter.string(from: endDate)]
        
        nasaAPI.getNasa(parameters: parameters) { [weak self] response in
            self?.decreceDate()
            completion(response.filter({ $0.media == "image" }))
        } completion: { (error) in
            debugPrint(error)
        }
    }
}

extension NasaViewModel {
    
    private func resetDate() {
        monthCurrent = 1
        self.startDate = getDateFor(month: -(monthCurrent + 1))!
        self.endDate = getDateFor(month: -monthCurrent)!
  
    }
    
    private func decreceDate() {
        monthCurrent += 1
        self.startDate = getDateFor(month: -(monthCurrent + 1))!
        self.endDate = getDateFor(month: -monthCurrent)!
        
    }
    
    private func getDateFor(month: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: month, to: Date())
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
}

