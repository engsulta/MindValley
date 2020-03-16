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
    var loadingState: [Int: LoadingState] = [0: .loading, 1: .loading, 2: .loading]
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
        channelTableVM.updateLoadingStatus = { [weak self] isLoading, tableSection in

            self?.loadingState[tableSection.sequence] = isLoading
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
            return loadingState[0]?.numberOfSection ?? 0
        case 1:
            let numberOfSections = (loadingState[1] == .succeed) ?  channelTableVM.channelsSectionsViewModels.count : loadingState[1]?.numberOfSection ?? 0
            return numberOfSections
        case 2:
            return loadingState[2]?.numberOfSection ?? 0
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard loadingState[0] == .succeed else {
                let cell:MediaShimmerViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                return cell
            }
            let cell:EpisodesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.episodesSectionVM = channelTableVM.episodesViewModels
            return cell

        case 1:
            guard loadingState[1] == .succeed else {
                let cell:MediaShimmerViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                return cell
            }
            let cell:ChannelTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.channelSectionVM = channelTableVM.channelsSectionsViewModels[indexPath.row]
            return cell

        case 2:
            guard loadingState[2] == .succeed else {
                let cell: CategoryShimmerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                return cell
            }
            let cell:CategoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.categoryVM = channelTableVM.categoryViewModel
            return cell
    
        default:
            return UITableViewCell()
        }
    }
}
