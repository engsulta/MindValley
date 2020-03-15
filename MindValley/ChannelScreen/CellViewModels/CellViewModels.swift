//
//  CellViewModels.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/14/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

struct EpisodeCellViewModel {
    let episodeTitle: String?
    let channelTitle: String?
    let coveriImageUrl: String?
}

struct ChannelSectionViewModel {
    let channelTitle: String?
    let channelIconUrl: String?
    let channelCoverIconUrl: String?
    let channelType: ChannelType
    var channelCount: String? = ""
    let channelItems: [ChannelCellViewModel]
    var mediaCount: String = "" {
        didSet {
            channelCount = "\(String(describing: channelCount)) \(channelType.rawValue)"
        }
    }
}

struct ChannelCellViewModel {
    let title: String?
    let coverImageUrl: String?
}

struct CategoryCellViewModel {
    var categortName: String?
}

enum ChannelType: String {
    case course = "episodes"
    case series = "series"
}
