//
//  SKitScrollView.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 12.04.2021.
//

import UIKit

protocol SKitScrollViewTouchesDelegate: class {
    func skitScrollView(_ scrollView: SKitScrollView, touchesBegan touches: Set<UITouch>, with event: UIEvent?)
}

final class SKitScrollView: UIScrollView {
    weak var touchesDelegate: SKitScrollViewTouchesDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        touchesDelegate?.skitScrollView(self, touchesBegan: touches, with: event)
    }
}
