//
//  MakeProtocol.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import UIKit

protocol MakeProtocol {}

extension MakeProtocol where Self: UIView {
    
    @discardableResult
    func make(_ completion: (Self) -> Void) -> Self {
        completion(self)
        return self
    }
    
}

// MARK: - MakeProtocol

extension UIView: MakeProtocol {}
