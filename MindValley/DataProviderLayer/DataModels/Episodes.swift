//
//  Episodes.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

struct EpisodesModel : Decodable {
    let media : [Media]?
}

struct Media : Decodable {
    let channel : EpisodeChannel?
    let coverAsset : CoverAsset?
    let title : String?
    let type : String?
}

struct CoverAsset : Decodable {
    let url : String?
}

struct EpisodeChannel : Decodable {
    let title : String?

}
