//
//  ShimmerViewTests.swift
//  MindValleyTests
//
//  Created by Ahmed Sultan on 3/16/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import XCTest
@testable import MindValley

class ShimmerViewTests: XCTestCase {

    var shimmerView: ShimmerView?

    override func setUp() {
        shimmerView = ShimmerView()
    }

    override func tearDown() {
        shimmerView = nil
    }

    func testGradientLayer() {
        let exp = expectation(description: "Shimmer effect")
        shimmerView?.startAnimation(duration: 2, completion: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5)
        guard let sublayer = shimmerView?.layer.sublayers?.first else {
            XCTFail("No subLayers")
            return
        }
        XCTAssertTrue(sublayer is CAGradientLayer)
    }

}
