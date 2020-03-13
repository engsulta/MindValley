//
//  ResultDecodable.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

struct ResultDecodable<T: Decodable>: Decodable {
    var data: T
}

