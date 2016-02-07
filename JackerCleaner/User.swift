//
//  User.swift
//  JackerCleaner
//
//  Created by 陳冠宇 on 2016/2/5.
//  Copyright © 2016年 陳冠宇. All rights reserved.
//

import Foundation
import CoreData

class UserInfo: NSManagedObject{
    @NSManaged var account:String!
    @NSManaged var password:String!
    
    
    
}
