//
//  MediaCollectionViewCell.swift
//  MindValley
//
//  Created by Ahmed Sultan on 3/13/20.
//  Copyright © 2020 hamza. All rights reserved.
//


import UIKit
@objc public protocol ReusableView {
    
}
extension ReusableView {
    
    /// Represents a default reuse id. It is the class name as string.
    /// Usually (99.99% of the times) we register the cell once. So a unique name would be the reuse id.
    public static var ReuseId: String {
        return String(describing: self)
    }
    
    /// Represents a default nib name. It is the class name as string.
    /// Usually (99.99% of the times) we name the nib as the class name.
    public static var NibName: String {
        return String(describing: self)
    }
}
@objc public protocol ReusableCell: ReusableView {
}

/// Make `UITableViewCell` reusable cell.
extension UITableViewCell: ReusableCell {
}

/// Make `UICollectionViewCell` reusable cell.
extension UICollectionViewCell: ReusableCell {
}

extension UIViewController {

    public class func instance<T: UIViewController>(from storyboardName: String,
                                                    with identifier: String = String("\(T.self)"),
                                                    bundle: Bundle? = nil) -> T {
        // if storyboard with storyboardName doesn't exist or bundle doesn't contain storyboard then init
        // of UIStoryboard will throw NSException
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let storyboardVC = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            print("can not instansiate the view controller")
            return T()
        }
        return storyboardVC
    }
}
