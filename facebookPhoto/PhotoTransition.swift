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
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! FeedViewController
        let toViewController = toViewController as! PhotoViewController
        
        tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFit
        tempImageView.image = selectedPhotoView.image
        feedViewController.view.addSubview(tempImageView)
        
        tempImageView.frame = feedViewController.view.convertRect(selectedPhotoView.frame, fromCoordinateSpace: selectedPhotoView.superview!)
        
        
        
        toViewController.view.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            self.tempImageView.frame = toViewController.view.convertRect(toViewController.photoView.frame, fromCoordinateSpace: toViewController.photoView.superview!)
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(self.duration, animations: {
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    self.tempImageView.removeFromSuperview()
                    self.finish()
                    
            }
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
