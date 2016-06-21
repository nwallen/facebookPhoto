//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class PhotoTransition: BaseTransition {
    
    var selectedPhotoView: UIImageView!
    var tempImageView: UIImageView!
    var imageViews: [UIImageView]!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! FeedViewController
        let toViewController = toViewController as! PhotoViewController
        
        tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFill
        tempImageView.clipsToBounds = true
        tempImageView.image = selectedPhotoView.image
       
        let tempBackgroundView = UIView()
        tempBackgroundView.backgroundColor = UIColor(white: 0, alpha: 1)
        tempBackgroundView.alpha = 0
        tempBackgroundView.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        
        tabViewController.view.addSubview(tempBackgroundView)
        tabViewController.view.addSubview(tempImageView)
        
        tempImageView.frame = feedViewController.view.convertRect(selectedPhotoView.frame, fromCoordinateSpace: selectedPhotoView.superview!)
        
        toViewController.view.alpha = 0
        let scaleFactor =   320 / self.selectedPhotoView.image!.size.width
        toViewController.photoView.frame = CGRect(x: 0, y: 0, width: 320, height: self.selectedPhotoView.image!.size.height * scaleFactor)
        toViewController.photoView.center = CGPoint(x:320/2, y:568/2)
        
        let targetFrame = toViewController.view.convertRect(toViewController.photoView.frame, fromCoordinateSpace: toViewController.photoView.superview!)
        
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 14, options: [], animations: { () -> Void in
            self.tempImageView.frame = targetFrame
            tempBackgroundView.alpha = 1
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    toViewController.view.alpha = 1

                    }, completion: { (Bool) -> Void in
                        self.tempImageView.removeFromSuperview()
                        tempBackgroundView.removeFromSuperview()
                        self.finish()
                        
                })
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = toViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! FeedViewController
        let fromViewController = fromViewController as! PhotoViewController
        
        let fromPhoto = fromViewController.hScrollPhotos[fromViewController.selectedIndex]
        let toPhoto = imageViews[fromViewController.selectedIndex]
        
        tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFill
        tempImageView.clipsToBounds = true
        tempImageView.image = fromPhoto.image
        feedViewController.view.addSubview(tempImageView)
        
        tempImageView.frame = fromViewController.view.convertRect(fromPhoto.frame, fromCoordinateSpace: fromPhoto.superview!)
        
        UIView.animateWithDuration(0.1, animations: {
            fromViewController.view.alpha = 0
            
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(self.duration * 0.65, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                    fromViewController.view.alpha = 0
                    self.tempImageView.frame = feedViewController.view.convertRect( toPhoto.frame, fromCoordinateSpace: toPhoto.superview!)
                }){ (Bool) -> Void in
                    self.tempImageView.removeFromSuperview()
                    self.finish()
                }
        }
        
    }
}
