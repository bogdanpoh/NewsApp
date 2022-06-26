//
//  WKInterfaceImage.Ext.swift
//  NewsAppWatch WatchKit Extension
//
//  Created by Bohdan Pokhidnia on 26.06.2022.
//

import WatchKit
import Rswift

extension WKInterfaceImage {
    
    func setupImage(urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString else {
            setImage(placeholder)
            return
        }
        
        Task {
            do {
                let imageData = try await NetworkService.getImage(with: urlString)
                setImageData(imageData)
            } catch {
                print("[dev] error setup image: \(error)")
                setImage(placeholder)
            }
        }
    }
    
}

extension ImageResource {
    
    func watchImage() -> UIImage? {
        return UIImage(named: name)
    }
    
}
