//
//  Channels.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

struct ChannelsModel : Decodable {
    let channels : [Channel]?
}

struct Channel : Decodable {
    let coverAsset : CoverAsset?
    let iconAsset : IconAssets?
    let id : String?
    let latestMedia : [LatestMedia]?
    let mediaCount : Int?
    let series : [Series]?
    let slug : String?
    let title : String?
    var channelType: ChannelType {
        if series?.count ?? 0 > 0 { return .series}
        else {return .course}
    }
}
struct IconAssets: Decodable {
    let thumbnailUrl: String?
}
struct Series : Decodable {
    let coverAsset : CoverAsset?
    let title : String?
}

struct LatestMedia : Decodable {
    let coverAsset : CoverAsset?
    let title : String?
    let type : String?
}
