//
//  WebServiceTests.swift
//  WebServiceTests
//
//  Created by Daniel Lee on 8/5/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import XCTest
@testable import Lickability

class WebServiceTests: XCTestCase {
    
    var webService: WebService?
    var swatchArray: [[Swatch]]?

    override func setUp() {
        super.setUp()
        webService = WebService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        webService = nil
        swatchArray = nil
        super.tearDown()
    }
    
    func testWebServiceSpeed() {
        measure {
            self.webService?.downloadObjectsAsJson { (swatches) in
                self.swatchArray = swatches
            }
        }
    }
    
    func testWebServiceCallSuccessful() {
        
        let promise = expectation(description: "Completed pulling swatches")
        
        webService?.downloadObjectsAsJson(completion: { (swatches) in
            
            XCTAssert(swatches.count > 0)
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
