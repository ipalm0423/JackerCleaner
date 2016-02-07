//
//  SecondViewController.swift
//  JackerCleaner
//
//  Created by 陳冠宇 on 2016/2/5.
//  Copyright © 2016年 陳冠宇. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var moreTabButton: UITabBarItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = "更多資訊"
    }
    
    override func viewWillAppear(animated: Bool) {
        print("MoreView view will appear")
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var items = ["關於潔客幫", "部落格", "我要當潔客", "潔客幫人才招募", "Facebook"]
    var urls = ["http://www.jackercleaning.com/home/about", "http://www.jackercleaning.com/blog/blogList", "http://www.jackercleaning.com/home/applyCleaner", "http://www.jackercleaning.com/home/applyStaff", "https://www.facebook.com/jackercleaner/"]
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.label1.text = items[indexPath.row]
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueWebSite" {
            
            let row = sender?.tag
            print("prepare for segue row: \(row)")
            if let VC = segue.destinationViewController as? WebSiteViewController {
                VC.url = self.urls[row!]
            }
            
        }
    }


}

