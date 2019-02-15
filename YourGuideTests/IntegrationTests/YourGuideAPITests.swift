//
//  YourGuideAPITests.swift
//  YourGuideTests
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import YourGuide

class YourGuideAPITests: XCTestCase {
    
    var request: RequestProtocol!
    var api: YourGuideAPIProtocol!
    let timeout = 10.0
    
    override func setUp() {
        super.setUp()
        request = AlamofireRequest()
        api = YourGuideAPI(provider: request)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetReviews() {
        let exp = expectation(description: "waiting service")
        let parameters = APIParameters(count: 3,
                                    page: 0,
                                    rating: 5,
                                    sortBy: .date,
                                    direction: .desc)
        
        api.getReviews(parameters: parameters) { error, result in
            XCTAssertNil(error)
            XCTAssertNotNil(result?.items?.first?.author)
            XCTAssertNotNil(result?.items?.first?.date)
            XCTAssertEqual(result?.items?.count, 3)
            XCTAssertEqual(result?.items?.first?.rating, "5.0")
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
}
