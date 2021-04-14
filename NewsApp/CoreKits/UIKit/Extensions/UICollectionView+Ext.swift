//
//  UICollectionView+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import UIKit

extension UICollectionView {
    
    /// Register nib for reuse
    func register<T: UICollectionViewCell>(nib cell: T.Type) {
        let className = String(describing: cell)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    /// Register class for reuse
    func register<T: UICollectionViewCell>(class cell: T.Type) {
        let className = String(describing: cell)
        register(cell, forCellWithReuseIdentifier: className)
    }
    
    /// Returns reusable cell
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: cell)
        let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
        return cell as! T
    }
    
}
