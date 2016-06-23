//
//  LoginManager.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/16.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit
import CoreData

var array : [NSManagedObject] = []
var managedContext : NSManagedObjectContext!
var entity : Entity!


class LoginManager: NSObject {
    
    //创建单例
    class var shareManager: LoginManager {
        
        struct Staitc {
            static var onceToken : dispatch_once_t = 0
            static var instance : LoginManager? = nil
        }
        dispatch_once(&Staitc.onceToken) {
            Staitc.instance = LoginManager()
        }
        return Staitc.instance!
        
    }
}

//查询信息
func search(tel:String,handler:(success:Bool)->(String)) {
    
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        managedContext = appdelegate?.managedObjectContext
        
        //2.建立一个获取的请求
        let fetchRequest = NSFetchRequest(entityName:"Entity")
        fetchRequest.predicate = NSPredicate(format: "tel = \(tel)")
        //3.执行请求
        do {
            
            let temp = try managedContext.executeFetchRequest(fetchRequest)as![NSManagedObject]
           
            if temp.count > 0 {
                
                entity = temp[0] as! Entity
                let result = handler(success: true)
                print("已经注册过了：\(result)")
            } else {
                
                let  result = handler(success: false)
                print("还未注册：\(result)")
                
            }
            
        } catch let error as NSError {
            
            print("无法获取数据 error：\(error) ")
            let result = handler(success: false)
            print("无法获取数据：\(result)")
        }
    
}

//MARK:登录
func loginIn(tel:String,password:String,handler:(success:Bool)->(String)) {
    
    search(tel) { (success) -> (String) in
        if success == true {
            
            let temp : String
                temp = handler(success: true)
                print("\(temp):登录成功")
            return "已注册:\(temp)"
        } else {
            
            let temp = handler(success: false)
            return "还没有注册:\(temp)"
        }
    }
    
}

