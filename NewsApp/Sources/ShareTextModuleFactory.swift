//
//  ShareTextModuleFactory.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.05.2021.
//

import UIKit

protocol ShareTextModuleFactoryProtocol {
    func makeShareTextView(text: String) -> Presentable
}

// MARK: - ShareTextModuleFactoryProtocol

extension ModulesFactory: ShareTextModuleFactoryProtocol {
    
    func makeShareTextView(text: String) -> Presentable {
        let shareText = [text]
        let activityViewController = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.addToReadingList
        ]
        return activityViewController
    }
    
}
