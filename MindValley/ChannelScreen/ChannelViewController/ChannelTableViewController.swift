//
//  ChannelTableViewController.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/14/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

class ChannelTableViewController: UITableViewController {
    
    var channelTableVM : ChannelTableViewModel = ChannelTableViewModel()
    var loadingStatus: [Int: Bool] = [0:true, 1: true, 2: true ]
    lazy var shimmerCell = MediaShimmerViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        initVM()
        
        fetchModels()
    }

    private func setupTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Channels"
        self.tableView.backgroundColor = UIColor(red:0.141, green:0.153, blue:0.180, alpha: 1.000)
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNib(cellNib: EpisodesTableViewCell.self)
        tableView.registerNib(cellNib: ChannelTableViewCell.self)
        tableView.registerNib(cellNib: CategoryTableViewCell.self)
        tableView.registerNib(cellNib: MediaShimmerViewCell.self)
        tableView.registerNib(cellNib: CategoryShimmerCell.self)
    }
    
    private func initVM() {
        channelTableVM.reloadTableSectionClosure = { [weak self] tableSection in
         //   self?.tableView.beginUpdates()
         //   self?.tableView.reloadSections([tableSection.sequence], with: .automatic)
          //  self?.tableView.endUpdates()
        }
        
        channelTableVM.updateLoadingStatus = { [weak self] isLoading, tableSection in
            // will be used to hide the loading for this section
            self?.loadingStatus[tableSection.sequence] = isLoading
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([tableSection.sequence], with: .automatic)
            self?.tableView.endUpdates()
        }
        
    }
    private func fetchModels() {
        channelTableVM.load(section: .episodes)
        channelTableVM.load(section: .channels)
        channelTableVM.load(section: .categories)
        
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            guard loadingStatus[0] == false else { return 1}
            let numberOfSections = (channelTableVM.episodesViewModels.count > 0 ) ?  1 : 0
            return numberOfSections
        case 1:
            guard loadingStatus[1] == false else { return 1}
            return channelTableVM.channelsSectionsViewModels.count
        case 2:
            guard loadingStatus[2] == false else { return 1}
            let numberOfSections =
            (channelTableVM.categoryViewModel.count > 0 ) ? 1 : 0
            return numberOfSections
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard loadingStatus[0] == false else {
                let cell:MediaShimmerViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                return cell
            }
            let cell:EpisodesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.episodesSectionVM = channelTableVM.episodesViewModels
            return cell
        case 1:
            guard loadingStatus[1] == false else {  let cell:MediaShimmerViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                           return cell}
            let cell:ChannelTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.channelSectionVM = channelTableVM.channelsSectionsViewModels[indexPath.row]
            return cell
        case 2:
            guard loadingStatus[2] == false else {  let cell: CategoryShimmerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                           return cell}
            let cell:CategoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.categoryVM = channelTableVM.categoryViewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
}
