//
//  MVEndPoints.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation
enum MVEndPoint: String {
    case newEpisodes = "https://pastebin.com/raw/z5AExTtw"
    case channels =  "https://pastebin.com/raw/Xt12uVhM"
    case categories = "https://pastebin.com/raw/A0CgArX3"
    var url: URL? {
        return URL(string: self.rawValue)
    }
}
