//
//  FeedViewController.swift
//  FacebookLab
//
//  Created by Nicholas Wallen on 5/18/16.
//  Copyright © 2016 Nicholas Wallen. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    
    // Right before the ViewController "appears"...
    override func viewWillAppear(animated: Bool) {
        // hide feed ImageView
        imageView.hidden = true
        // turn on the activity indicator
        loadingIndicator.startAnimating()
    }
    
    // The moment the ViewController "appears"...
    override func viewDidAppear(animated: Bool) {
        // Delay for 2 seconds before...
        delay(2) { () -> () in
            // show the feed ImageView
            self.imageView.hidden = false
            // Stop the activity indicator
            self.loadingIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = imageView.image!.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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