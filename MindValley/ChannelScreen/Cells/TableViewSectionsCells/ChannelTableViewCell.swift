//
//  ChannelTableViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    var columns = Constants.Collections.columns
    let inset = Constants.Collections.inset
    let spacing = Constants.Collections.spacing
    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var mediaCountLabel: UILabel!
    
    var channelSectionVM: ChannelSectionViewModel! {
        didSet {

            mediaCountLabel.text = "\(channelSectionVM.channelCount ?? "")  \(channelSectionVM.channelType.rawValue)"
            channelTitle.text = channelSectionVM.channelTitle
            ImageCoordinator.getImage(withURLString: channelSectionVM.channelIconUrl) { [weak self] (iconImage, error) in
                if let iconImage = iconImage {
                    self?.channelImageView.image = iconImage
                    self?.contentView.layoutIfNeeded()
                }
            }
            switch channelSectionVM.channelType {
            case .course:
                columns = 2
            case .series:
                columns = 1.2
               
            }
             mediaCollectionView.reloadData()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
          setupUI()
          setupCollectionView()
    }

    private func setupUI() {
        // cell background setup
        self.mediaCollectionView.backgroundColor = .clear
        self.contentView.backgroundColor = Constants.TableCells.background
        
        // image view setup
        self.channelImageView.layer.cornerRadius = self.channelImageView.frame.height / 2
        self.channelImageView.clipsToBounds = true
        
        // label colors
        self.channelTitle.textColor = .white
        self.mediaCountLabel.textColor = .gray
    }
    
    private func setupCollectionView() {
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        mediaCollectionView.isScrollEnabled = true
        mediaCollectionView.registerNib(cellNib: MediaCollectionViewCell.self)
        mediaCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.mediaCollectionView.layoutIfNeeded()
        self.mediaCollectionView.frame = CGRect.init(origin: .zero, size: CGSize.init(width: targetSize.width, height: 500))
        return self.mediaCollectionView.collectionViewLayout.collectionViewContentSize
    }
    
}

// MARK: UICollectionViewDataSource
extension ChannelTableViewCell: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return channelSectionVM.channelItems.count
  }
  
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MediaCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    
    // Configure the cell
    cell.channelCellVM = channelSectionVM.channelItems[indexPath.item]
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ChannelTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = Int(((collectionView.frame.width) / columns) - (inset + spacing))
        
    return CGSize(width: width, height: 2 * width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
}
