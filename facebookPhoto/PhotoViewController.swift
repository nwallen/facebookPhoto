//
//  PhotoViewController.swift
//  FacebookLab
//
//  Created by Nicholas Wallen on 5/19/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var actionsView: UIImageView!
    @IBOutlet weak var doneButtonView: UIImageView!
    
    var expandedPhoto: UIImage!
    
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
        return photoView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let combinedOffset = abs(scrollView.contentOffset.x) + abs(scrollView.contentOffset.y)
        var alpha = convertValue(combinedOffset , r1Min: 0, r1Max: 60, r2Min: 1.0, r2Max: 0.6)
        if alpha < 0.6 {
            alpha = 0.6
        }
        self.view.backgroundColor = UIColor(white: 0, alpha: alpha)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let combinedOffset = abs(scrollView.contentOffset.x) + abs(scrollView.contentOffset.y)
        if combinedOffset > 60 {
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
    
    override func viewWillAppear(animated: Bool) {
        photoView.image = expandedPhoto
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
