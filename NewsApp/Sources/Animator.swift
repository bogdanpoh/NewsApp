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
    
    static let duration: TimeInterval = 0.7

    private let type: PresentationType
    private let firstViewController: FeedViewController
    private let secondViewController: DetailsViewController
    private var selectedCellImageViewSnapshot: UIView
    private var cellImageViewRect: CGRect
    private var cellWith: CGFloat = 382

    private let cellLabelRect: CGRect

    init?(type: PresentationType, firstViewController: FeedViewController, secondViewController: DetailsViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.contentView.window ?? secondViewController.contentView.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }

        self.cellImageViewRect = selectedCell.articleImageView.convert(selectedCell.articleImageView.bounds, to: window)

        self.cellLabelRect = selectedCell.titleLabel.convert(selectedCell.titleLabel.bounds, to: window)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }

        containerView.addSubview(toView)

        guard let selectedCell = firstViewController.selectedCell,
              let window = firstViewController.contentView.window ?? secondViewController.contentView.window,
              let cellImageSnapshot = selectedCell.articleImageView.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = secondViewController.contentView.articleImage.snapshotView(afterScreenUpdates: true),
              let cellLabelSnapshot = selectedCell.titleLabel.snapshotView(afterScreenUpdates: true),
              let closeButtonSnapshot = secondViewController.contentView.closeButton.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }

        let isPresenting = type.isPresenting

        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.contentView.backgroundColor

        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot

            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = firstViewController.contentView.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }

        toView.alpha = 0

        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot, cellLabelSnapshot, closeButtonSnapshot].forEach { containerView.addSubview($0) }


        let controllerImageViewRect = secondViewController.contentView.articleImage.convert(secondViewController.contentView.articleImage.bounds, to: window)
        let controllerLabelRect = secondViewController.contentView.titleLabel.convert(secondViewController.contentView.titleLabel.bounds, to: window)
        let closeButtonRect = secondViewController.contentView.closeButton.convert(secondViewController.contentView.closeButton.bounds, to: window)

        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect

            $0.layer.cornerRadius = isPresenting ? 12 : 0
            $0.layer.masksToBounds = true
        }

        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

        cellLabelSnapshot.frame = isPresenting ? cellLabelRect : controllerLabelRect

        closeButtonSnapshot.frame = closeButtonRect
        closeButtonSnapshot.alpha = isPresenting ? 0 : 1

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect

                fadeView.alpha = isPresenting ? 1 : 0
                cellLabelSnapshot.frame = isPresenting ? controllerLabelRect : self.cellLabelRect

                [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = isPresenting ? 0 : 12
                }
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }

            UIView.addKeyframe(withRelativeStartTime: isPresenting ? 0.7 : 0, relativeDuration: 0.3) {
                closeButtonSnapshot.alpha = isPresenting ? 1 : 0
            }
        }, completion: { isFinish in
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()

            backgroundView.removeFromSuperview()
            cellLabelSnapshot.removeFromSuperview()
            closeButtonSnapshot.removeFromSuperview()

            toView.alpha = 1

            transitionContext.completeTransition(isFinish)
        })
    }
}
