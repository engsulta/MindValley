//
//  ImageCoordinator.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit
final class ImageCoordinator {
    typealias KingFisherCompletionHandler = (UIImage?, Error?) -> Void
    static func getImage(withURLString urlString: String?, completion: @escaping KingFisherCompletionHandler) {
        guard let photoURLString = urlString,
            let url = URL(string: photoURLString) else {
                completion(nil, nil)
                return
        }
        
        let imageCacheKey = photoURLString
        let resource = ImageResource(downloadURL: url, cacheKey: imageCacheKey)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            DispatchQueue.main.async {
                completion(image, error)
            }
        }
    }
}
