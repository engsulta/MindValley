//
//  MVErrorTest.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import XCTest
@testable import MindValley

class MVErrorTest: XCTestCase {
    func testErrorLocalizedDescription() {
        let expected: [String] = [
                                  "missing URL",
                                  "no Internet Connection",
                                  "unable to decode the response",
                                  "unknown"]

        for (index, testError) in [
                                   MVError.missingURL,
                                   MVError.noInternetConnection,
                                   MVError.faildToDecode,
                                   MVError.unknown].enumerated() {
                                    XCTAssertEqual(testError.rawValue, expected[index])
        }
    }
}
