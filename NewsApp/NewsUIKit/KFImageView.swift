//
//  KFImageView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 17.04.2021.
//

import Kingfisher

final class KFImageView: ImageView {
    
}

extension KFImageView {
    
    @discardableResult
    func setImage(path: String?, placeholder: UIImage? = nil, completion: @escaping (Result<UIImage, Error>) -> Void = { _ in }) -> Self {
        guard let urlString = path else {
            completion(.failure(NetworkError.init(code: 400, errorType: .unknown, message: "nil path for image")))
            return self
        }
        
        kf.setImage(with: URL(string: urlString), placeholder: placeholder) { result in
            switch result {
            case .success(let imageResult):
                completion(.success(imageResult.image))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return self
    }
    
}
