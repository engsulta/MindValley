//
//  HelperProtocols.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}


protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
   
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}




extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}



extension URLSessionDataTask: URLSessionDataTaskProtocol {}
