//
//  MediaCollectionViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit
import Kingfisher

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaDefaultBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaZeroBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
//    var height: CGFloat {
//        let mediaTitleHeight = mediaTitle.intrinsicContentSize.height
//        let channelTitleHeight = channelTitle.intrinsicContentSize.height
//        let mediaImageHeight = mediaImageView.intrinsicContentSize.height
//        
//        return mediaTitleHeight + channelTitleHeight + mediaImageHeight + 46
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//    }
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: self.contentView.frame.width, height: height)
//    }
    
    var episodeCellVM: EpisodeCellViewModel! {
        didSet {
            mediaDefaultBottomConstraint.priority = UILayoutPriority(rawValue: 999)
            mediaZeroBottomConstraint.priority = .defaultLow
            mediaTitle.text = episodeCellVM.episodeTitle
            channelTitle.text = episodeCellVM.channelTitle
            ImageCoordinator.getImage(withURLString: episodeCellVM.coveriImageUrl) { [weak self] (image, error) in
                if let image = image {
                    self?.mediaImageView.image = image
                    self?.contentView.setNeedsLayout()
                }
            }
            
        }
    }
    var channelCellVM: ChannelCellViewModel! {
        didSet {
            mediaDefaultBottomConstraint.priority = .defaultLow
            mediaZeroBottomConstraint.priority = UILayoutPriority(rawValue: 999)
            mediaTitle.text = channelCellVM.title ?? "......"
            channelTitle.text?.removeAll()
            ImageCoordinator.getImage(withURLString: channelCellVM.coverImageUrl) { [weak self] (image, error) in
                if let image = image {
                    self?.mediaImageView.image = image
                }
            }
            self.contentView.setNeedsLayout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI() {
        // add shadow for image view
        self.mediaImageView.layer.cornerRadius = 10
        self.mediaImageView.layer.shadowColor = UIColor(red:0.584, green:0.596, blue:0.616, alpha: 1.000).cgColor
        self.mediaImageView.layer.shadowOpacity = 0.7
        self.mediaImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.mediaImageView.layer.shadowRadius = 5
        
        // label colors
        mediaTitle.textColor = .white
        channelTitle.textColor = UIColor(red:0.584, green:0.596, blue:0.616, alpha: 1.000)
        
        // background
    }
}
