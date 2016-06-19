//
//  LoginViewController.swift
//  FacebookLab
//
//  Created by Nicholas Wallen on 5/26/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fbLogoImageView: UIImageView!
    @IBOutlet weak var fieldSuperview: UIView!
    @IBOutlet weak var labelSuperview: UIView!
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    var logoInitialY: CGFloat!
    var logoOffset: CGFloat!
    var fieldInitialY: CGFloat!
    var fieldOffset: CGFloat!
    var labelInitialY: CGFloat!
    var labelOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        logoInitialY = fbLogoImageView.frame.origin.y
        logoOffset =  -40
        fieldInitialY = fieldSuperview.frame.origin.y
        fieldOffset = -40
        labelInitialY = labelSuperview.frame.origin.y
        labelOffset = -225
        
        loginButton.enabled = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditing(sender: AnyObject) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    
    }
    
    @IBAction func didPressLogin(sender: AnyObject) {
        loginButton.selected = true
        loginIndicator.startAnimating()
        delay(2.0){
            self.loginIndicator.stopAnimating()
            self.loginButton.selected = false
            if self.emailField.text == "user@email.com" && self.passwordField.text == "pass" {
                self.performSegueWithIdentifier("showTabController", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Access Denied", message: "Wrong Email or Password", preferredStyle: .Alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        fbLogoImageView.frame.origin.y = logoInitialY + logoOffset
        fieldSuperview.frame.origin.y = fieldInitialY + fieldOffset
        labelSuperview.frame.origin.y = labelInitialY + labelOffset
        
        UIView.animateWithDuration(0.1){
            self.signUpLabel.alpha = 0
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        fbLogoImageView.frame.origin.y = logoInitialY
        fieldSuperview.frame.origin.y = fieldInitialY
        labelSuperview.frame.origin.y = labelInitialY
        
        UIView.animateWithDuration(0.1){
            self.signUpLabel.alpha = 1
        }
        
        
    }
    
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
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
