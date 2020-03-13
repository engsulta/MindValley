//
//  NetworkManager.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation
typealias NetworkCompletion = ( Decodable?, Error? ) -> Void

protocol MVNetworkManagerProtocol {
    var session: URLSessionProtocol { get }
    func request<T: Decodable>(path: MVEndPoint, model: T.Type, completion: @escaping NetworkCompletion)
}

class MVNetworkManager: MVNetworkManagerProtocol {
    static let shared = {
        return MVNetworkManager()
    }()
    var session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension MVNetworkManager {
    func request<T>(path: MVEndPoint, model: T.Type, completion: @escaping NetworkCompletion) where T : Decodable {
        guard let url = path.url else {
            DispatchQueue.main.async {
                completion(nil, MVError.missingURL)
            }
            return
        }
        let currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            // get status
            guard error == nil, let jsonData = data else {
                DispatchQueue.main.async {completion(nil, error)}
                return}
            // map  response
            do {
                
                let modelType = ResultDecodable<T>.self
                let responseModel = try JSONDecoder().decode(modelType, from: jsonData)
                print(responseModel)
                DispatchQueue.main.async {
                    completion(responseModel, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, MVError.faildToDecode)
                }
            }
            
        })
        currentTask.resume()
    }
}

