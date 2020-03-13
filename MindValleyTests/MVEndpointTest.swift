//
//  MVEndpointTest.swift
//  MindValleyTests
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//



import XCTest
@testable import MindValley

class MVEndPointTest: XCTestCase {
    func testEndpointLocalizedDescription() {
        let expected: [String] = [
                                  "https://pastebin.com/raw/z5AExTtw",
                                  "https://pastebin.com/raw/Xt12uVhM",
                                  "https://pastebin.com/raw/A0CgArX3"]

        for (index, testEndpoint) in [
                                   MVEndPoint.newEpisodes,
                                   MVEndPoint.channels,
                                   MVEndPoint.categories].enumerated() {
                                    XCTAssertEqual(testEndpoint.rawValue, expected[index])
                                    XCTAssertEqual(testEndpoint.url, URL(string: expected[index]))
        }
    }
}
