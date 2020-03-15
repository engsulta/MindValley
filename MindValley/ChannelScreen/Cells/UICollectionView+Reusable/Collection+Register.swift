//
//  MediaCollectionViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func registerNib(cellNib cell: ReusableCell.Type, in bundle: Bundle? = nil) {
        let nib = UINib(nibName:cell.NibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cell.ReuseId)
    }
    
    public func registerClass(cellClass cell: ReusableCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.ReuseId)
    }
    
    func dequeueReusableCell<T: ReusableCell>(forIndexPath indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.ReuseId, for: indexPath ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.ReuseId)")
        }
        return cell
    }
}



extension UITableView {

    
    public func registerNib(cellNib cell: ReusableCell.Type, in bundle: Bundle? = nil) {
        let nib = UINib(nibName:cell.NibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: cell.ReuseId)
    }
    
    public func registerClass(cellClass cell: ReusableCell.Type) {
        register(cell, forCellReuseIdentifier: cell.ReuseId)
    }
    
 
    
    func dequeueReusableCell<T: ReusableCell>(forIndexPath indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableCell(withIdentifier: T.ReuseId, for: indexPath ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.ReuseId)")
        }
        
        return cell
    }
}

