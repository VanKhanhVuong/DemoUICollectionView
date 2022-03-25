//
//  TransitionManager.swift
//  DemoUICollectionView
//
//  Created by admin on 25/03/2022.
//

import UIKit

@objc
protocol ZoomingViewController
{
        func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
        func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView?
}

final class ZoomTransitioningDelegate: NSObject {
    
    var transitionDuration = 0.5
    var operation: UINavigationController.Operation = .none
    
    
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        
        
    }
}

extension ZoomTransitioningDelegate : UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}

//private extension TransitionManager {
//    func animateTransition(from fromViewController: UIViewController, to toViewController: UIViewController, with context: UIViewControllerContextTransitioning) {
//        switch operation {
//        case .push:
//            guard
//                let homeViewController = fromViewController as? HomeViewController,
//                let detailViewController = toViewController as? DetailViewController
//            else { return }
//            presentViewController(detailViewController, from: homeViewController, with: context)
//
//        case .pop:
//            guard
//                let detailViewController = fromViewController as? DetailViewController,
//                let homeViewController = toViewController as? HomeViewController
//            else { return }
//            dismissViewController(detailViewController, to: homeViewController, with: context)
//
//        default:
//            break
//        }
//    }
//
//    func presentViewController(_ toViewController: DetailViewController, from fromViewController: HomeViewController, with context: UIViewControllerContextTransitioning){
//
//        // Lấy các uiview trong cell
//        guard
//            let newsCell = fromViewController.newsCell,
//            let newsImageViewCell = fromViewController.newsCell?.newsImageView,
//            let titleLabelCell = fromViewController.newsCell?.titleCellLabel
//        else {
//            return
//        }
//
//        // Detail view
//        toViewController.view.layoutIfNeeded()
//
//        let containerView = context.containerView
//
//        // Tạo 1 View (ViewA) trong spapScreen
//        let snapshotContentView = UIView()
//        snapshotContentView.backgroundColor = .white
//        snapshotContentView.frame = containerView.convert(newsCell.contentView.frame, from: newsCell)
//        snapshotContentView.layer.cornerRadius = newsCell.contentView.layer.cornerRadius
//
//        // Tạo cái ImageView trong snapScreen
//        let snapshotAlbumCoverImageView = UIImageView()
//        snapshotAlbumCoverImageView.clipsToBounds = true
//        snapshotAlbumCoverImageView.contentMode = newsImageViewCell.contentMode
//        snapshotAlbumCoverImageView.image = newsImageViewCell.image
//        snapshotAlbumCoverImageView.layer.cornerRadius = newsImageViewCell.layer.cornerRadius
//        snapshotAlbumCoverImageView.frame = containerView.convert(newsImageViewCell.frame, from: newsCell)
//
//        // Tạo label trong snapScreen
//        let snapshotLabel = UILabel()
//        snapshotLabel.contentMode = titleLabelCell.contentMode
//        snapshotLabel.text = titleLabelCell.text
//        snapshotLabel.textColor = titleLabelCell.textColor
//        snapshotLabel.font = titleLabelCell.font
//        snapshotLabel.textAlignment = titleLabelCell.textAlignment
//        snapshotLabel.frame = containerView.convert(titleLabelCell.frame, from: newsCell)
//
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(snapshotContentView)
//        containerView.addSubview(snapshotAlbumCoverImageView)
//        containerView.addSubview(snapshotLabel)
//
//        // Cho detail screen ẩn đi
//        toViewController.view.isHidden = true
//
//        // Tạo chuyển động
//        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
//            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
//            snapshotAlbumCoverImageView.frame = containerView.convert(toViewController.newsImageView.frame, from: toViewController.contentView)
//            snapshotLabel.frame = containerView.convert(toViewController.titleLabel.frame, from: toViewController.contentView)
//        }
//
//        // Khi chuyển động hoàn thành thì thực hiện
//        animator.addCompletion { position in
//            toViewController.view.isHidden = false
//            snapshotAlbumCoverImageView.removeFromSuperview()
//            snapshotLabel.removeFromSuperview()
//            snapshotContentView.removeFromSuperview()
//            context.completeTransition(position == .end)
//        }
//        animator.startAnimation()
//    }
//
//    func dismissViewController(_ fromViewController: DetailViewController, to toViewController: HomeViewController, with context: UIViewControllerContextTransitioning){
//
//        // Lấy các uiview trong cell
//        guard
//            let newsCell = toViewController.newsCell
//        else {
//            return
//        }
//
//        // Detail view
//        toViewController.view.layoutIfNeeded()
//
//        let containerView = context.containerView
//
//        // Tạo 1 View (ViewA) trong spapScreen
//        let snapshotContentView = UIView()
//        snapshotContentView.backgroundColor = .white
//        snapshotContentView.frame = containerView.convert(fromViewController.contentView.frame, from: fromViewController.contentView)
//        snapshotContentView.layer.cornerRadius = fromViewController.contentView.layer.cornerRadius
//
//        // Tạo cái ImageView trong snapScreen
//        let snapshotAlbumCoverImageView = UIImageView()
//        snapshotAlbumCoverImageView.contentMode = fromViewController.newsImageView.contentMode
//        snapshotAlbumCoverImageView.image = fromViewController.newsImageView.image
//        snapshotAlbumCoverImageView.layer.cornerRadius = fromViewController.newsImageView.layer.cornerRadius
//        snapshotAlbumCoverImageView.frame = containerView.convert(fromViewController.newsImageView.frame, from: fromViewController.view)
//
//        // Tạo label trong snapScreen
//        let snapshotLabel = UILabel()
//        snapshotLabel.contentMode = fromViewController.titleLabel.contentMode
//        snapshotLabel.text = fromViewController.titleLabel.text
//        snapshotLabel.textColor = fromViewController.titleLabel.textColor
//        snapshotLabel.font = fromViewController.titleLabel.font
//        snapshotLabel.textAlignment = fromViewController.titleLabel.textAlignment
//        snapshotLabel.frame = containerView.convert(fromViewController.titleLabel.frame, from: newsCell)
//
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(snapshotContentView)
//        containerView.addSubview(snapshotAlbumCoverImageView)
//        containerView.addSubview(snapshotLabel)
//
//        // Cho detail screen ẩn đi
//        toViewController.view.isHidden = true
//
//        // Tạo chuyển động
//        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
//            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
//            snapshotAlbumCoverImageView.frame = containerView.convert(newsCell.newsImageView.frame, from: newsCell)
//            snapshotLabel.frame = containerView.convert(newsCell.titleCellLabel.frame, from: newsCell)
//        }
//
//        // Khi chuyển động hoàn thành thì thực hiện
//        animator.addCompletion { position in
//            toViewController.view.isHidden = false
//            snapshotAlbumCoverImageView.removeFromSuperview()
//            snapshotLabel.removeFromSuperview()
//            snapshotContentView.removeFromSuperview()
//            context.completeTransition(position == .end)
//        }
//        animator.startAnimation()
//    }
//}
