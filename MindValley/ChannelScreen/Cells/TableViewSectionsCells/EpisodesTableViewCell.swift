//
//  EpisodesTableViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/14/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    let columns = Constants.Episodecollections.columns
    let inset = Constants.Episodecollections.inset
    let spacing = Constants.Episodecollections.spacing
    @IBOutlet weak var episodeSectionTitle: UILabel!
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    var episodesSectionVM: [EpisodeCellViewModel] = []{
        didSet {
            episodesCollectionView.reloadData()
             self.contentView.layoutIfNeeded()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupCollectionView()
    }
    private func setupUI() {
        episodeSectionTitle.text = "New Episodes"
        episodeSectionTitle.textColor = UIColor(red:0.584, green:0.596, blue:0.616, alpha: 1.000)
        self.episodesCollectionView.backgroundColor = .clear
        self.contentView.backgroundColor = Constants.TableCells.background
    }
    private func setupCollectionView() {
        
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        episodesCollectionView.isScrollEnabled = true
        episodesCollectionView.registerNib(cellNib: MediaCollectionViewCell.self)
        episodesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.episodesCollectionView.layoutIfNeeded()
        self.episodesCollectionView.frame = CGRect.init(origin: .zero, size: CGSize.init(width: targetSize.width, height: 500))
       
        return self.episodesCollectionView.collectionViewLayout.collectionViewContentSize
        
    }
}

// MARK: UICollectionViewDataSource
extension EpisodesTableViewCell: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return episodesSectionVM.count
  }
  
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MediaCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    
    // Configure the cell
    cell.episodeCellVM = episodesSectionVM[indexPath.item]
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension EpisodesTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = Int(((collectionView.frame.width) / columns) - (inset + spacing))
        
    return CGSize(width: width, height: 2 * width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
}
