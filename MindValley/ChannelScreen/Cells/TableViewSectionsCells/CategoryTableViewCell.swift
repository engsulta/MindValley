//
//  CategoryTableViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/14/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    let columns = Constants.CategoryCollections.columns
    let inset = Constants.CategoryCollections.inset
    let spacing = Constants.CategoryCollections.spacing
    
    @IBOutlet weak var categorySectionTitle: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categoryVM: [CategoryCellViewModel] = []{
        didSet {
            categoryCollectionView.reloadData()
            contentView.layoutIfNeeded()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupCollectionView()
    }
    private func setupUI() {
        // title setup
        categorySectionTitle.text = "Browse by categories"
        categorySectionTitle.textColor = UIColor(red:0.584, green:0.596, blue:0.616, alpha: 1.000)
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        contentView.backgroundColor = Constants.TableCells.background
    }
    private func setupCollectionView() {
   categoryCollectionView.isScrollEnabled = false
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.registerNib(cellNib: CategoryCollectionViewCell.self)
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.categoryCollectionView.layoutIfNeeded()
        let correctHeight = self.categorySectionTitle.intrinsicContentSize.height + 32 + categoryCollectionView.collectionViewLayout.collectionViewContentSize.height
        let correctWidth =  categoryCollectionView.collectionViewLayout.collectionViewContentSize.width
        
        return CGSize(width: correctWidth, height: correctHeight)
    }
}

// MARK: UICollectionViewDataSource
extension CategoryTableViewCell: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryVM.count
  }
  
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    
    // Configure the cell
    cell.categoryCellViewModel = categoryVM[indexPath.item]
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = Int(((collectionView.frame.width - 84) / 2) - 2*(inset + spacing))
        
    return CGSize(width: width, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
}
