//
//  ResquestManagerTests.swift
//  desafio_iosTests
//
//  Created by Lelio Jorge on 01/04/21.
//

import Foundation

import XCTest
@testable import desafio_ios

class RequestManagerTests: XCTestCase {
    let manager = AlamofireManager()

    func testRequest() {
        let delay: TimeInterval =  10
        let expectation = XCTestExpectation()

        let parameters = ["start_date": "1995-06-16",
                          "end_date" : "1995-07-16"]
        let url: URL = URL(string: "https://api.nasa.gov/planetary/apod?api_key=7pxN7UvwbOYkly3y2Qed45Izuo0J5iqZOKXQA6Hp")!

  
        let _ = manager.request(url: url, method: .get, parameters: parameters, headers: [:]) { (response) in
            switch response {
            
            case let .success(data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
        wait(for: [expectation], timeout: delay)

    }
    
    func testCancelRequest() {
        testRequest()
        self.manager.cancelTask(byUrl: URL(string: "https://api.nasa.gov/planetary/apod?api_key=7pxN7UvwbOYkly3y2Qed45Izuo0J5iqZOKXQA6Hp")!)
    }
    
    


}
