//
//  WebViewController.swift
//  JackerCleaner
//
//  Created by 陳冠宇 on 2016/2/5.
//  Copyright © 2016年 陳冠宇. All rights reserved.
//

import UIKit


class WebViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet var webView: UIWebView!
    
    var url = "http://www.jackercleaning.com/auth/cleanerLogin"
    
    var isAutoFilled = false
    var account = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.delegate = self
        self.loadWebPage()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadWebPage() {
        let theURL = self.url
        let theRequestURL = NSURL (string: theURL)
        let theRequest = NSURLRequest (URL: theRequestURL!)
        webView.loadRequest(theRequest)
    }

    
    func webAutoFilled() {
        var html = self.webView.stringByEvaluatingJavaScriptFromString("document.documentElement.outerHTML;")
        
        if var htmlFinal = html {
            print("load HTML with modify")
            let range1 = html?.rangeOfString("<input", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
            if let acRange = range1 {
                print("input user account, password")
                htmlFinal.replaceRange(acRange, with: "<input value='\(self.account)'")
                
                let accountCount = 9 + self.account.characters.count
                let start = acRange.endIndex.advancedBy(accountCount) // Start at the string's start index
                let end = htmlFinal.endIndex
                let searchRange: Range<String.Index> = Range<String.Index>(start: start,end: end)
                print(searchRange)
                
                let range2 = htmlFinal.rangeOfString("<input", options: NSStringCompareOptions.CaseInsensitiveSearch, range: searchRange, locale: nil)
                print(range2)
                if let pwRange = range2 {
                    htmlFinal.replaceRange(pwRange, with: "<input value='\(self.password)'")
                }
                
                
                
            }
            self.isAutoFilled = true
            self.webView.loadHTMLString(htmlFinal, baseURL: nil)
        }
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("web finished loaded")
        if !self.isAutoFilled {
            self.webAutoFilled()
            
        }
        
        /*
        let savedUsername = "123"//NSUserDefaults.standardUserDefaults().stringForKey("USERNAME")
        let savedPassword = "456"//NSUserDefaults.standardUserDefaults().stringForKey("PASSWORD")
        
        //if savedUsername == nil || savedPassword == nil {return}
        print("auto load user AC, PW")
        let loadUsernameJS = "var inputFields = document.querySelectorAll(\"input[name='username']\"); \\ for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '\(savedUsername)';}"
        let loadPasswordJS = "var inputFields = document.querySelectorAll(\"input[type='password']\"); \\ for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = \'\(savedPassword)\';}"
        
        //self.webView.stringByEvaluatingJavaScriptFromString(t1)
        self.webView.stringByEvaluatingJavaScriptFromString(loadUsernameJS)
        //if ( countElements(savedUsername!) != 0 && countElements(savedPassword!) != 0) {
            
        //}*/
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


