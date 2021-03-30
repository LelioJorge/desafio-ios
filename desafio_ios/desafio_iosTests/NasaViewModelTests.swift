//
//  ViewModelTests.swift
//  desafio_iosTests
//
//  Created by Lelio Jorge on 30/03/21.
//

import Foundation

import XCTest
@testable import desafio_ios

class NasaViewModelTests: XCTestCase {

    func testNasaViewModelNasaDownload() {
        let vm = NasaViewModel(manager: AlamofireManager())
        let expectation = XCTestExpectation()
        let expectation2 = XCTestExpectation()
 
        let delay: TimeInterval = 60
        
        vm.getNasa { (nasa) in
            
            debugPrint(nasa)
            XCTAssertNotNil(nasa)
            expectation.fulfill()
            
        }
        
        vm.getNasa { (nasa) in
            
            debugPrint(nasa)
            XCTAssertNotNil(nasa)
            expectation2.fulfill()
            
        }
        
        wait(for: [expectation,expectation2], timeout: delay)
    }
    
    func testNasaViewModelImageDownload() {
        let vm = NasaViewModel(manager: AlamofireManager())
        
        let expectation = XCTestExpectation()
        let expectation2 = XCTestExpectation()

        let delay: TimeInterval = 60
        
        vm.getNasa { (nasa) in
            let nasa2 = nasa
            debugPrint(nasa)
            XCTAssertNotNil(nasa)
            expectation.fulfill()
            vm.getImage(nasa: nasa2) { (image) in
                debugPrint(image)
                XCTAssertNotNil(image)
                expectation2.fulfill()
            }
        }
        
       
        
        wait(for: [expectation,expectation2], timeout: delay)

    }

}
