//
//  DownloadTests.swift
//  desafio_iosTests
//
//  Created by Lelio Jorge on 30/03/21.
//

import Foundation

import XCTest
@testable import desafio_ios

class DownloadTests: XCTestCase {

    func testDownloadNasaApi() {
        let delay: TimeInterval =  5
        let expectation = XCTestExpectation()
        let nasaApi = NasaAPI(manager: AlamofireManager())

        let parameters = ["start_date": "1995-06-16",
                          "end_date" : "1995-07-16"]
        
        nasaApi.getNasa(parameters: parameters) { response in
            debugPrint(response)
            XCTAssertNotNil(response)
            expectation.fulfill()
            
        } completion: { (error) in
            debugPrint(error)
            XCTAssertNil(error)
        }
        
        wait(for: [expectation], timeout: delay)

    }
    
    func testDownloadImageApi() {
        let delay: TimeInterval =  5
        let expectation = XCTestExpectation()
        let imageApi = ImageAPI(manager: AlamofireManager())
        
        imageApi.getImage(url: URL(string: "https://apod.nasa.gov/apod/image/orion_hst.gif")!, completion: { response in
            
            XCTAssertNotNil(response)
            expectation.fulfill()
            
        })
        wait(for: [expectation], timeout: delay)

    }
    
    func testDownloadsNasaApi() {
        let delay: TimeInterval =  10
        let expectation = XCTestExpectation()
        let expectation2 = XCTestExpectation()

        let nasaApi = NasaAPI(manager: AlamofireManager())

        let parameters = ["start_date": "1995-06-16",
                          "end_date" : "1995-07-16"]
        let parameters2 = ["start_date": "1995-08-16",
                          "end_date" : "1995-09-16"]
        
        nasaApi.getNasa(parameters: parameters) { response in
            print("Primeiro Download")
            XCTAssertNotNil(response)
            expectation.fulfill()
        } completion: { (error) in
            debugPrint(error)
            XCTAssertNil(error)
        }
        
        nasaApi.getNasa(parameters: parameters2) { response in
            print("Segundo Download")
            XCTAssertNotNil(response)
            expectation2.fulfill()
            
        } completion: { (error) in
            debugPrint(error)
            XCTAssertNil(error)
        }
        
        wait(for: [expectation,expectation2], timeout: delay)

    }

}
