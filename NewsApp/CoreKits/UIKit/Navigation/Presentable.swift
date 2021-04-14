//
//  Presentable.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}

// MARK: - Presentable

extension UIViewController: Presentable {
    
    var toPresent: UIViewController? { self }
    
}
