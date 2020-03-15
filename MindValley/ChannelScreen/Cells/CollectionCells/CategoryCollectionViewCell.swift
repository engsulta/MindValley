//
//  CategoryCollectionViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var name: UILabel!
    var categoryCellViewModel: CategoryCellViewModel! {
        didSet {
            self.name.text = categoryCellViewModel.categortName
            //self.contentView.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        self.backView.backgroundColor = UIColor(red: 149/255, green:152/255, blue:157/255, alpha: 0.2)
        self.contentView.backgroundColor = .clear
        self.backView.layer.cornerRadius = self.backView.frame.height / 2
        name.textColor = .white
        //name.font
        
    }
}
