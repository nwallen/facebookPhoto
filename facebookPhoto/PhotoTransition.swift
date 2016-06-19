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
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFill
        tempImageView.clipsToBounds = true
        tempImageView.image = selectedPhotoView.image
        feedViewController.view.addSubview(tempImageView)
        
        tempImageView.frame = feedViewController.view.convertRect(selectedPhotoView.frame, fromCoordinateSpace: selectedPhotoView.superview!)
        
        toViewController.view.alpha = 0
        let scaleFactor =   320 / self.selectedPhotoView.image!.size.width
        toViewController.photoView.frame = CGRect(x: 0, y: 0, width: 320, height: self.selectedPhotoView.image!.size.height * scaleFactor)
        toViewController.photoView.center = CGPoint(x:320/2, y:568/2)
        
        let targetFrame = toViewController.view.convertRect(toViewController.photoView.frame, fromCoordinateSpace: toViewController.photoView.superview!)
        
        UIView.animateWithDuration(duration, animations: {
            self.tempImageView.frame = targetFrame
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, animations: {
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    self.tempImageView.removeFromSuperview()
                    self.finish()
            }
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = toViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! FeedViewController
        let fromViewController = fromViewController as! PhotoViewController
        
        
        tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFill
        tempImageView.clipsToBounds = true
        tempImageView.image = selectedPhotoView.image
        feedViewController.view.addSubview(tempImageView)
        
        tempImageView.frame = fromViewController.view.convertRect(fromViewController.photoView.frame, fromCoordinateSpace: fromViewController.photoView.superview!)
        
        UIView.animateWithDuration(0.1, animations: {
            fromViewController.view.alpha = 0
          
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(self.duration, animations: {
                    self.tempImageView.frame = feedViewController.view.convertRect( self.selectedPhotoView.frame, fromCoordinateSpace: self.selectedPhotoView.superview!)
                  
                    }) { (finished: Bool) -> Void in
                        self.tempImageView.removeFromSuperview()
                        self.finish()
                        
                }
        }
     
    }
}
