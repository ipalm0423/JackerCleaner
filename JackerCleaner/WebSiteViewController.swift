//
//  WebSiteViewController.swift
//  JackerCleaner
//
//  Created by 陳冠宇 on 2016/2/7.
//  Copyright © 2016年 陳冠宇. All rights reserved.
//

import UIKit

class WebSiteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadWebPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var url = ""
    
    @IBOutlet var webView: UIWebView!
    
    
    
    
    func loadWebPage() {
        let theURL = self.url
        let theRequestURL = NSURL (string: theURL)
        let theRequest = NSURLRequest (URL: theRequestURL!)
        webView.loadRequest(theRequest)
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
