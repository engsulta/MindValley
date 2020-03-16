//
//  ChannelTableViewTest.swift
//  MindValleyTests
//
//  Created by Ahmed Sultan on 3/16/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import XCTest
@testable import MindValley

class ChannelTableViewTest: XCTestCase {
     var channelVC: ChannelTableViewController!

       override func setUp() {
           super.setUp()
        
        channelVC =  ChannelTableViewController.instance(from: "Main")
    }

    override func tearDown() {
        channelVC = nil
    }

    func testShimming() {
         
        XCTAssertEqual(channelVC.loadingState[0], .loading)
        XCTAssertEqual(channelVC.loadingState[1], .loading)
        XCTAssertEqual(channelVC.loadingState[2], .loading)
    }
    
}
