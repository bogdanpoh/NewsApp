//
//  UIViewController+Ext.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 10.04.2021.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        addFullScreenConstraints(view: view, childView: child.view)
        child.didMove(toParent: self)
    }
    
    func add(child: UIViewController, to childContainerView: UIView) {
        addChild(child)
        childContainerView.addSubview(child.view)
        addFullScreenConstraints(view: childContainerView, childView: child.view)
        child.didMove(toParent: self)
    }
    
    func remove(child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        guard child.view != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    private func addFullScreenConstraints(view: UIView, childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: childView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            view.topAnchor.constraint(equalTo: childView.topAnchor),
            view.bottomAnchor.constraint(equalTo: childView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        view.addConstraints(constraints)
    }
    
}

extension UIViewController {
    
    func embedInNavigation() -> UINavigationController {
        return .init(rootViewController: self)
    }
    
}

extension UIViewController {
    
    func topmostViewController(controller: UIViewController? = UIApplication.shared.mainWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topmostViewController(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topmostViewController(controller: selected)
            }
        }

        if let presented = controller?.presentedViewController {
            return topmostViewController(controller: presented)
        }

        return controller
    }
    
}
