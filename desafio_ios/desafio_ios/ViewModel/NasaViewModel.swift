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
    private var nasaInformations: [Nasa] = []
    
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
    

    
    func getImage(nasa: Nasa, completion: @escaping (UIImage) -> Void) -> Void {
        
        guard let image = imageCache.object(forKey: nasa.title as NSString) else {
            imageAPI.getImage(url: URL(string: nasa.url)!) { [self] (image) in
                imageCache.setObject(image!, forKey: nasa.title as NSString)
                completion(image!)
            }
            return
        }
        
        completion(image)
        
    }
    
    func getNasa(completion: @escaping (Nasa) -> Void) -> Void {
        
        guard let nasa = nasaInformations.first else {
            loadNasa { [self] in
                guard let nasa = nasaInformations.first else {return}
                nasaInformations.removeFirst()
                completion(nasa)
            }
            return
        }
        nasaInformations.removeFirst()
        completion(nasa)
        
    }
    
    private func loadNasa(completion: @escaping () -> Void) {
        dispathGroup.enter()
 
        if startDate < finalyDate {
            resetDate()
        }
        let parameters = [Parameters.startDate.value: dateToString(date: startDate),
                          Parameters.endDate.value : dateToString(date: endDate)]
        
        nasaAPI.getNasa(parameters: parameters) { [weak self] response in
            self?.nasaInformations.append(contentsOf: response)
            self?.dispathGroup.leave()
            self?.decreceDate()
            completion()
        } completion: { (error) in
            debugPrint(error)
            self.dispathGroup.leave()
        }
    }
    

}

extension NasaViewModel {
    
    private func resetDate() {
        self.startDate = getDateFor(month: -2)!
        self.endDate = getDateFor(month: -1)!
        monthCurrent = 1
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

