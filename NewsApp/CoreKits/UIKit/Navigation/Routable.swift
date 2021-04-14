//
//  Routable.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import Foundation

typealias CompletionBlock = () -> Void

protocol PresentRoutable {
    func topPresent(_ module: Presentable?)
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
}

protocol PushRoutable {
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
}

protocol PopRoutable {
    func popModule()
    func popModule(animated: Bool)
}

protocol DismissRoutable {
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    func dismissTopmost(animated: Bool, completion: CompletionBlock?)
}

protocol RootRoutable {
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}

protocol Routable: Presentable
                   & PresentRoutable
                   & PushRoutable
                   & PopRoutable
                   & DismissRoutable
                   & RootRoutable
{ }
