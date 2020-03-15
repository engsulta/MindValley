//
//  ChannelListViewModel.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import Foundation

class ChannelTableViewModel {
    
    /// view model closures to be injected by the view controller
    var reloadTableSectionClosure: (( _ section: ScreenSection)->())?
    var updateLoadingStatus: (( _ state: Bool, _ section: ScreenSection)->())?

    //MARK: -  VM properties
    var episodesViewModels: [EpisodeCellViewModel] = [EpisodeCellViewModel]()
    var channelsSectionsViewModels: [ChannelSectionViewModel] = [ChannelSectionViewModel]()
    var categoryViewModel: [CategoryCellViewModel] = [CategoryCellViewModel]()
 
    //MARK: - start Fetching data
    func load(section: ScreenSection) {
        
         /// update loading state for each section
        self.updateLoadingStatus?(true, section)
        section.execute { [weak self] responseModel, error, section in
            guard let self = self else { return }
            
            let screenSection = ScreenSection(endPoint: section)
            /// stop loading section or hide shimmer for this section
            self.updateLoadingStatus?(false, screenSection)
            
            /// do not do any thing in case of error so when section reload will not show this section
            guard error == nil, let response = responseModel else { return }
            
            switch section {
            case .newEpisodes:
                if let episodes = (response as? EpisodesModel)?.media {
                self.mapEpisodesToViewModel(episodes: episodes) }
                
            case .channels:
                if let channels = (response as? ChannelsModel)?.channels {
                    self.mapChannelsToViewModel(channels: channels) }
                
            case .categories:
                if let categories = (response as? CategoriesModel)?.categories {
                    self.mapCategoriesToViewModel(categories: categories) }
                
            }
            /// reload table for each section
            self.reloadTableSectionClosure?(screenSection)
        }
           
    }
    
    // MARK:- Mapping fetched data
    private func mapChannelsToViewModel(channels: [Channel]) {
        channels.forEach{(channel) in
            
            var channelVMS = [ChannelCellViewModel]()
            
            if channel.channelType == .course {
                channel.latestMedia?.forEach {
                    let channelVM = ChannelCellViewModel(title: $0.title, coverImageUrl: $0.coverAsset?.url)
                    channelVMS.append(channelVM)
                }
            } else if channel.channelType == .series {
                channel.series?.forEach {
                    let channelVM = ChannelCellViewModel(title: $0.title, coverImageUrl: $0.coverAsset?.url)
                    channelVMS.append(channelVM)
                }
            }
            let channelSectionVM = ChannelSectionViewModel(channelTitle: channel.title,
                                                           channelIconUrl: channel.iconAsset?.thumbnailUrl,
                                                           channelCoverIconUrl: channel.coverAsset?.url,
                                                           channelType: channel.channelType,
                                                           channelCount: String(channel.mediaCount ?? 0),
                                                           channelItems: channelVMS)
            self.channelsSectionsViewModels.append(channelSectionVM)
        }
    }

    
    private func mapEpisodesToViewModel(episodes: [Media]) {
        episodes.forEach { (episode) in
            let episodeVM = EpisodeCellViewModel(episodeTitle: episode.title,
                                                 channelTitle: episode.channel?.title,
                                                 coveriImageUrl: episode.coverAsset?.url)
            self.episodesViewModels.append(episodeVM)
        }
    }
    private func mapCategoriesToViewModel(categories: [Category]) {
        categories.forEach {
            self.categoryViewModel.append(CategoryCellViewModel(categortName: $0.name))
        }
    }
}
