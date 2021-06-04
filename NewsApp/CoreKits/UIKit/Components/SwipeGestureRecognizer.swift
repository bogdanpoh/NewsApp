//
//  SwipeGestureRecognizer+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 03.06.2021.
//

import UIKit

class SwipeGestureRecognizer: UISwipeGestureRecognizer {
    
    private var onSwipeAction: (() -> Void) = {}
    
}

// MARK: - User interactions

extension SwipeGestureRecognizer {
    
    @objc func swipeAction() {
        onSwipeAction()
    }
    
}

extension SwipeGestureRecognizer {
    
    @discardableResult
    func whenSwipe(action: @escaping () -> Void) -> Self {
        self.onSwipeAction = action
        addTarget(self, action: #selector(swipeAction))
        return self
    }
    
    @discardableResult
    func set(swipeDirection: UISwipeGestureRecognizer.Direction) -> Self {
        direction = swipeDirection
        return self
    }
    
}
