//
//  ChannelTableVMTests.swift
//  MindValleyTests
//
//  Created by Ahmed Sultan on 3/16/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import XCTest
@testable import MindValley

class ChannelTableVMTests: XCTestCase {
    
    var channelVM: ChannelTableViewModel!
    lazy var dataProviderMock: MVNetworkManagerProtocol = MVNetworkManager(session: MockSession())
    
    override func setUp() {
        channelVM = ChannelTableViewModel()
    }

    override func tearDown() {
        channelVM = nil
    }

    func testLoadSection() {
//        let exp = expectation(description: #function)
        channelVM.dataProvider = self.dataProviderMock
        channelVM.updateLoadingStatus = {  isLoading, tableSection in
            XCTAssertEqual(isLoading, .loading)
            XCTAssertEqual(tableSection, .channels)
        }
        channelVM.load(section: .channels)
        
        channelVM.updateLoadingStatus = { isLoading, tableSection in
            XCTAssertEqual(isLoading, .loading)
            XCTAssertEqual(tableSection, .episodes)
        }
        channelVM.load(section: .episodes)
        
        channelVM.updateLoadingStatus = { isLoading, tableSection in
            XCTAssertEqual(isLoading, .loading)
            XCTAssertEqual(tableSection, .categories)
        }
        channelVM.load(section: .categories)
  }
    
    func testMapChannelsToViewModel() {
        let channels = [Channel(coverAsset: nil, iconAsset: nil, id: nil, latestMedia: nil, mediaCount: nil, series: nil, slug: nil, title: "myChannel")]
        
        channelVM.mapChannelsToViewModel(channels: channels)
        
        XCTAssertEqual(channelVM?.channelsSectionsViewModels.first?.channelTitle, channels.first?.title)
    }
    
    func testMapEpisodesToViewModel() {
           let series = [Media(channel: nil, coverAsset: nil, title: "myepisode", type: nil)]
           
           channelVM.mapEpisodesToViewModel(episodes: series)
           
           XCTAssertEqual(channelVM?.episodesViewModels.first?.episodeTitle, series.first?.title)
       }
    func testMapCategoriesToViewModel() {
        let categories = [Category(name:"test")]
           
           channelVM.mapCategoriesToViewModel(categories: categories)
           
        XCTAssertEqual(channelVM?.categoryViewModel.first?.categortName, categories.first?.name)
       }
}
