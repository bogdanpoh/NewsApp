//
//  Animator.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 15.07.2022.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    enum PresentationType {
        case present
        case dismiss

        var isPresenting: Bool {
            return self == .present
        }
    }
    
    static let duration: TimeInterval = 0.6

    private let type: PresentationType
    private let fromViewController: FeedViewController
    private let toViewController: DetailsViewController
    private let window: UIWindow
    private var selectedCellImageViewSnapshot: UIView
    
    private let cellImageViewCoordinate: CGRect
    private let cellLabelCoordinate: CGRect
    private let cellAuthorLabelCoordinate: CGRect

    init?(type: PresentationType, fromViewController: FeedViewController, toViewController: DetailsViewController, selectedCell: NewsCollectionViewCell) {
        guard let window = fromViewController.contentView.window ?? toViewController.contentView.window,
              let selectedCellImageViewSnapshot = selectedCell.articleImageView.snapshotView(afterScreenUpdates: true)
        else { return nil }
        
        self.type = type
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.window = window
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        self.cellImageViewCoordinate = selectedCell.articleImageView.convertSelfBounds(to: window)
        self.cellLabelCoordinate = selectedCell.titleLabel.convertSelfBounds(to: window)
        self.cellAuthorLabelCoordinate = selectedCell.authorLabel.convertSelfBounds(to: window)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = toViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        let toViewControllerContent = toViewController.contentView
        let isPresenting = type.isPresenting
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        guard let selectedCell = fromViewController.selectedCell,
              let cellImageSnapshot = selectedCell.articleImageView.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = toViewControllerContent.articleImage.snapshotView(afterScreenUpdates: true),
              var cellTitleLabelSnapshot = selectedCell.titleLabel.snapshotView(afterScreenUpdates: true),
              var cellAuthorLabelSnapshot = selectedCell.authorLabel.snapshotView(afterScreenUpdates: true),
              let controllerDescriptionLabelSnapshot = toViewControllerContent.descriptionLabel.snapshotView(afterScreenUpdates: true),
              let controllerCloseButtonSnapshot = toViewControllerContent.closeButton.snapshotView(afterScreenUpdates: true),
              let controllerShareButtonSnapshot = toViewControllerContent.shareButton.snapshotView(afterScreenUpdates: true),
              let controllerOpenButtonSnapshot = toViewControllerContent.openButton.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }

        let backgroundView: UIView
        let fadeView = UIView()
        fadeView.backgroundColor = toViewControllerContent.backgroundColor
        
        var cellFadeViewCoordinate = selectedCell.contentView.convert(selectedCell.contentView.bounds, to: window)
        cellFadeViewCoordinate.origin.x += selectedCell.leftCellOffset
        cellFadeViewCoordinate.origin.y += selectedCell.topCellOffset
        cellFadeViewCoordinate.size.width = selectedCell.bounds.width - (selectedCell.leftCellOffset + selectedCell.rightCellOffset)
        cellFadeViewCoordinate.size.height -= selectedCell.topCellOffset
        
        let controllerFadeViewCoordinate = toViewController.view.convert(toViewController.view.bounds, to: window)
        fadeView.frame = isPresenting ? cellFadeViewCoordinate : controllerFadeViewCoordinate

        if isPresenting {
            if let presentedCellLabelSnapshot = toViewControllerContent.titleLabel.snapshotView(afterScreenUpdates: true) {
                cellTitleLabelSnapshot = presentedCellLabelSnapshot
            }
            
            if let presentedCellAuthorLabelSnapshot = toViewControllerContent.authorLabel.snapshotView(afterScreenUpdates: true) {
                cellAuthorLabelSnapshot = presentedCellAuthorLabelSnapshot
            }
            
            selectedCellImageViewSnapshot = cellImageSnapshot
            backgroundView = UIView(frame: containerView.bounds)
        } else {
            backgroundView = fromViewController.contentView.snapshotView(afterScreenUpdates: true) ?? fadeView
        }
        
        backgroundView.addSubview(fadeView)
        toView.alpha = 0
        
        containerView.addSubviews(
            backgroundView,
            selectedCellImageViewSnapshot,
            controllerImageSnapshot,
            cellTitleLabelSnapshot,
            cellAuthorLabelSnapshot,
            controllerDescriptionLabelSnapshot,
            controllerCloseButtonSnapshot,
            controllerShareButtonSnapshot,
            controllerOpenButtonSnapshot
        )
        
        let controllerImageViewCoordinate = toViewControllerContent.articleImage.convertSelfBounds(to: window)
        let controllerLabelCoordinate = toViewControllerContent.titleLabel.convertSelfBounds(to: window)
        let controllerAuthorLabelCoordinate = toViewControllerContent.authorLabel.convertSelfBounds(to: window)
        let controllerDescriptionLabelCoordinate = toViewControllerContent.descriptionLabel.convertSelfBounds(to: window)
        let controllerCloseButtonCoordinate = toViewControllerContent.closeButton.convertSelfBounds(to: window)
        let controllerShareButtonCoordinate = toViewControllerContent.shareButton.convertSelfBounds(to: window)
        let controllerOpenButtonCoordinate = toViewControllerContent.openButton.convertSelfBounds(to: window)

        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewCoordinate : controllerImageViewCoordinate
        }
        
        [fadeView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.layer.cornerRadius = isPresenting ? 15 : 0
            $0.layer.masksToBounds = true
        }

        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

        cellTitleLabelSnapshot.frame = isPresenting ? cellLabelCoordinate : controllerLabelCoordinate
        cellAuthorLabelSnapshot.frame = isPresenting ? cellAuthorLabelCoordinate : controllerAuthorLabelCoordinate
        
        controllerDescriptionLabelSnapshot.make {
            $0.frame = isPresenting ? makeMoveToUpFrame(for: $0, isPresenting: isPresenting) : controllerDescriptionLabelCoordinate
            $0.alpha = isPresenting ? 0 : 1
        }

        controllerCloseButtonSnapshot.frame = controllerCloseButtonCoordinate
        controllerCloseButtonSnapshot.alpha = isPresenting ? 0 : 1
        
        controllerShareButtonSnapshot.make {
            $0.frame = isPresenting ? makeMoveToDownFrame(for: $0) : controllerShareButtonCoordinate
            $0.alpha = isPresenting ? 0 : 1
        }
        
        controllerOpenButtonSnapshot.make {
            $0.frame = isPresenting ? makeMoveToDownFrame(for: $0) : controllerOpenButtonCoordinate
            $0.alpha = isPresenting ? 0 : 1
        }

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                fadeView.frame = isPresenting ? controllerFadeViewCoordinate : cellFadeViewCoordinate
                
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewCoordinate : self.cellImageViewCoordinate
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewCoordinate : self.cellImageViewCoordinate

                cellTitleLabelSnapshot.frame = isPresenting ? controllerLabelCoordinate : self.cellLabelCoordinate
                cellAuthorLabelSnapshot.frame = isPresenting ? controllerAuthorLabelCoordinate : self.cellAuthorLabelCoordinate

                [fadeView, controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = isPresenting ? 0 : 15
                }
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
                
                controllerShareButtonSnapshot.make {
                    $0.frame = isPresenting ? controllerShareButtonCoordinate : self.makeMoveToDownFrame(for: $0)
                    $0.alpha = isPresenting ? 1 : 0
                }
                
                controllerOpenButtonSnapshot.make {
                    $0.frame = isPresenting ? controllerOpenButtonCoordinate : self.makeMoveToDownFrame(for: $0)
                    $0.alpha = isPresenting ? 1 : 0
                }
            }

            UIView.addKeyframe(withRelativeStartTime: isPresenting ? 0.7 : 0, relativeDuration: isPresenting ? 0.3 : 0) {
                controllerDescriptionLabelSnapshot.make {
                    $0.frame = isPresenting ? controllerDescriptionLabelCoordinate : self.makeMoveToUpFrame(for: $0, isPresenting: isPresenting)
                    $0.alpha = isPresenting ? 1 : 0
                }
                
                controllerCloseButtonSnapshot.alpha = isPresenting ? 1 : 0
            }
        }, completion: { (isFinish) in
            [backgroundView,
             self.selectedCellImageViewSnapshot,
             controllerImageSnapshot,
             cellTitleLabelSnapshot,
             cellAuthorLabelSnapshot,
             controllerCloseButtonSnapshot,
             controllerShareButtonSnapshot,
             controllerOpenButtonSnapshot
            ].forEach {
                $0.removeFromSuperview()
            }

            toView.alpha = 1
            transitionContext.completeTransition(isFinish)
        })
    }
}

// MARK: - Private

private extension Animator {
    
    func makeMoveToUpFrame(for view: UIView, isPresenting: Bool) -> CGRect {
        let x = (window.frame.width / 2) - (view.frame.width / 2)
        let y: CGFloat = isPresenting ? (window.frame.height / 2) : view.frame.origin.y + view.frame.height
        
        return .init(origin: .init(x: x, y: y), size: view.frame.size)
    }
    
    func makeMoveToDownFrame(for view: UIView) -> CGRect {
        let x = (window.frame.width / 2) - (view.frame.width / 2)
        let y = window.frame.height
        
        return .init(origin: .init(x: x, y: y), size: view.frame.size)
    }
    
}
