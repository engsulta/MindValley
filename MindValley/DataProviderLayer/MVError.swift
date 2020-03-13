//
//  MVError.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

enum MVError: String, Error {
    case missingURL = "missing URL"
    case noInternetConnection = "no Internet Connection"
    case faildToDecode = "unable to decode the response"
    case unknown = "unknown"
}
