//
//  CategoryShimmerCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/16/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class CategoryShimmerCell: UITableViewCell {

    @IBOutlet var shimmerdViews: [ShimmerView]!
    
        override func awakeFromNib() {
            super.awakeFromNib()
            startShimmer()
        }
        
        func startShimmer() {
            shimmerdViews.forEach { (shimmerdView) in
                shimmerdView.startAnimation()
                shimmerdView.layer.cornerRadius = shimmerdView.frame.height / 2
            }
        }
    }
