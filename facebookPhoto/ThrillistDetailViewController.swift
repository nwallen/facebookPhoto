//
//  ThrillistDetailViewController.swift
//  FacebookLab
//
//  Created by Nicholas Wallen on 5/19/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class ThrillistDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var initialY: CGFloat!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        initialY = commentView.frame.origin.y
        offset = -175
        scrollView.contentSize = imageView.image!.size
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButton(sender: UIButton) {
        
        sender.selected = !sender.selected
    }

    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        UIView.animateWithDuration(0.3, delay: 0.02, options:[], animations:{
              self.commentView.frame.origin.y = self.initialY + self.offset
        }, completion: nil)
      
    }
    
    func keyboardWillHide(notification: NSNotification!) {
       commentView.frame.origin.y = initialY
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
