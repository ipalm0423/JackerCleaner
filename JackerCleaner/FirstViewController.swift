//
//  FirstViewController.swift
//  JackerCleaner
//
//  Created by 陳冠宇 on 2016/2/5.
//  Copyright © 2016年 陳冠宇. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
        self.loadUserData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var logInButton: UIButton!
    
    @IBOutlet var phoneButton: UIButton!
    
    
    @IBOutlet var accountField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
//view setup
    func setupView() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.view.frame
        gradient.colors = [UIColor(red: 47 / 255, green: 178 / 255, blue: 208 / 255, alpha: 1).CGColor, UIColor(red: 72 / 255, green: 221 / 255, blue: 238 / 255, alpha: 1).CGColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        self.view.layer.insertSublayer(gradient, atIndex: 0)
        
        self.logInButton.layer.cornerRadius = self.logInButton.frame.height / 2
        self.logInButton.clipsToBounds = true
        
        self.phoneButton.layer.cornerRadius = self.phoneButton.frame.height / 2
        self.phoneButton.clipsToBounds = true
        
        //keyboard
        let tap = UITapGestureRecognizer(target: self, action: "onTouchGesture")
        self.view.addGestureRecognizer(tap)
        
        //navigation title
        self.title = "登入"
    }
    
    
//core data
    var user = [String]()
    var fetchResultController: NSFetchedResultsController!
    var fetchRequest = NSFetchRequest(entityName: "UserInfo")
    
    func saveAccount(account: String, password: String) {
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        print("save user information to CoreData...")
        //2
        let entity =  NSEntityDescription.entityForName("UserInfo",
            inManagedObjectContext:managedContext)
        
        let user = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        user.setValue(account, forKey: "account")
        user.setValue(password, forKey: "password")
        
        //4
        do {
            try managedContext.save()
            print("save user information successs")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func loadUserData() {
        print("load user data")
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let MOC = appDelegate.managedObjectContext
        
        do {
            let results = try MOC.executeFetchRequest(self.fetchRequest) as! [UserInfo]
            
            if results.count > 0 {
                print("already have account to log in: count = \(results.count)")
                self.accountField.text = results[0].account
                self.passwordField.text = results[0].password
            }else {
                print("no account to log in")
            }
        }catch{
            print(error)
        }
    }
    
    
    
    
    @IBAction func accountFieldEnd(sender: AnyObject) {
        print("return press")
        sender.resignFirstResponder!()
    }
    
    func onTouchGesture(){
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func phoneButtonTouch(sender: AnyObject) {
        print("phone button touch")
        self.alertPhoneWarning()
    }
    
    
    @IBAction func logInButtonTouch(sender: AnyObject) {
        print("log in button touch")
        if self.accountField.text == "" || self.passwordField.text == "" {
            print("no account or password input")
            self.alertAcPwEmpty()
        }else {
            print("have account & password")
            self.performSegueWithIdentifier("SegueWeb", sender: self)
        }
    }
    
    
    func alertAcPwEmpty() {
        let alert = UIAlertController(title: "帳號密碼有誤", message: "帳號或密碼不能空白", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true) { () -> Void in
            print("alert for PW, AC empty")
        }
        
    }
    
    func alertPhoneWarning() {
        let alert = UIAlertController(title: "撥打電話", message: "需要幫您打電話給鄭小姐嗎？", preferredStyle: UIAlertControllerStyle.Alert)
        
        //agree
        alert.addAction(UIAlertAction(title: "好的", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                print("call Ms. Chang: 0965501132", terminator: "")
                //not allow health store
                if let phoneCallURL:NSURL = NSURL(string: "tel://0965501132") {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(phoneCallURL)) {
                        application.openURL(phoneCallURL);
                    }
                }
                
            case .Cancel:
                print("取消", terminator: "")
                
            case .Destructive:
                print("destructive", terminator: "")
            }
        }))
        
        //cancel
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueWeb" {
            //save to CoreData
            if self.user.count == 0 {
                self.saveAccount(self.accountField.text!, password: self.passwordField.text!)
            }
            //transfer to destination view
            if let VC = segue.destinationViewController as? WebViewController {
                print("prepare for segue")
                VC.account = self.accountField.text!
                VC.password = self.passwordField.text!
            }
        }
    }
    
    
}

