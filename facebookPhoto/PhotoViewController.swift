//
//  PhotoViewController.swift
//  FacebookLab
//
//  Created by Nicholas Wallen on 5/19/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fullScrollView: UIScrollView!
    
    @IBOutlet weak var actionsView: UIImageView!
    @IBOutlet weak var doneButtonView: UIImageView!
    
    var expandedPhoto: UIImage!
    var photos: [UIImageView]!
    var selectedIndex: Int!
    
    var hScrollPhotos: [UIImageView] = []
    var panGestureRecognizer: UIPanGestureRecognizer!
    var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    var originalPhotoCenter: CGPoint!
    var originalContentOffset: CGPoint!
    
    override func viewWillAppear(animated: Bool) {
        photoView.image = expandedPhoto
        fullScrollView.contentSize = CGSize(width: 320 * photos.count - 1, height: 568)
        fullScrollView.contentOffset = CGPointMake(fullScrollView.frame.size.width * CGFloat(selectedIndex), 0);
        
        fullScrollView.delegate = self;
        createPhotoScroll()
    }
    
    func createPhotoScroll(){
        for i in 0...photos.count - 1 {
            let thisPhoto = UIImageView()
            thisPhoto.image = photos[i].image
            
            let scaleFactor =   320 / thisPhoto.image!.size.width
            thisPhoto.frame = CGRect(x: CGFloat(320 * i), y: 0, width: 320, height: thisPhoto.image!.size.height * scaleFactor)
            thisPhoto.center.y = 568/2
            fullScrollView.addSubview(thisPhoto)
            hScrollPhotos.append(thisPhoto)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        destroyPhotoScroll()
    }
    
    func destroyPhotoScroll(){
        for i in 0...hScrollPhotos.count - 1 {
            hScrollPhotos[i].removeFromSuperview()
        }
    }
    
    func showAllPhotos(){
        for i in 0...hScrollPhotos.count - 1 {
            hScrollPhotos[i].alpha = 1
        }
    }
    
    func showOnePhoto(photoIndex: Int){
        for i in 0...hScrollPhotos.count - 1 {
            if i != photoIndex {
                hScrollPhotos[i].alpha = 0
            } else {
                hScrollPhotos[i].alpha = 1
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView.contentSize = photoView.frame.size

        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.2){
            self.actionsView.alpha = 0
            self.doneButtonView.alpha = 0
        }
        
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        UIView.animateWithDuration(0.2){
            self.actionsView.alpha = 0
            self.doneButtonView.alpha = 0
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return hScrollPhotos[selectedIndex]
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = abs(scrollView.contentOffset.y)
        var alpha = convertValue(yOffset , r1Min: 0, r1Max: 100, r2Min: 1.0, r2Max: 0.6)
        if alpha < 0.6 {
            alpha = 0.6
        }
        
        if yOffset > 5{
            showOnePhoto(selectedIndex)
        }
        
        self.view.backgroundColor = UIColor(white: 0, alpha: alpha)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let combinedOffset = abs(scrollView.contentOffset.y)
        if combinedOffset > 20 {
            dismissViewControllerAnimated(true
                , completion: { () -> Void in
                    
            })
        } else {
            UIView.animateWithDuration(0.2){
                self.actionsView.alpha = 1
                self.doneButtonView.alpha = 1
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        selectedIndex = lround(Double(fullScrollView.contentOffset.x) / 320)
         print(selectedIndex)
        showAllPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }
    
    
}
