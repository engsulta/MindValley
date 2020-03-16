//
//  ScreenSection.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/14/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

// will map to number of sections
enum LoadingState {
    case loading
    case succeed
    case failed
    var numberOfSection: Int {
        switch self {
        case .loading, .succeed:
            return 1
        default:
            return 0
        }
    }
}

enum ScreenSection {
    case episodes
    case channels
    case categories
    var sequence: Int {
        switch self {
        case .episodes:
            return 0
        case .channels:
           return 1
        case .categories:
            return 2}
    }
    var endPoint: MVEndPoint {
        switch self {
        case .episodes:
            return MVEndPoint.newEpisodes
        case .channels:
            return MVEndPoint.channels
        case .categories:
            return MVEndPoint.categories
            
        }
    }
    init(endPoint: MVEndPoint) {
        switch endPoint {
        case .newEpisodes:
            self = ScreenSection.episodes
        case .channels:
            self = ScreenSection.channels
        case .categories:
            self = ScreenSection.categories
            
        }
    }
    func execute(using provider: MVNetworkManagerProtocol, completion: @escaping NetworkCompletion) {
        switch self {
        case .episodes:
             provider.request(path: self.endPoint, model: EpisodesModel.self, completion: completion)
        case .channels:
              provider.request(path: self.endPoint, model: ChannelsModel.self, completion: completion)
        case .categories:
              provider.request(path: self.endPoint, model: CategoriesModel.self, completion: completion)
        }
        
    }
    
    
}
