//
//  RegisterManager.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/16.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit
import CoreData

//var managedContext : NSManagedObjectContext!

class RegisterManager: NSObject {
    class var shareManager: RegisterManager {
        struct Staitc {
            static var onceToken : dispatch_once_t = 0
            static var instance : RegisterManager? = nil
        }
        dispatch_once(&Staitc.onceToken) {
            Staitc.instance = RegisterManager()
        }
        return Staitc.instance!
    }
}
//查询信息
func searchTel(tel:String,handler:(success:Bool)->(String)) {
    
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        managedContext = appdelegate?.managedObjectContext
        
        //2.建立一个获取的请求
        let fetchRequest = NSFetchRequest(entityName:"Entity")
        fetchRequest.predicate = NSPredicate(format: "tel = \(tel)")
        
        //3.执行请求
        do {
            
            let temp =  try managedContext?.executeFetchRequest(fetchRequest)as! [NSManagedObject]?
            if temp?.count > 0 {
                
                entity = temp![0] as! Entity
                print("registerManager中注册的信息为：\(entity)")
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

//添加信息
func register(tel:String,password:String,confirmPassword:String,image:String,handel:(success:Bool)->(String)) {
    
    searchTel(tel) { (success) -> (String) in
        if success {
            
            let  result = handel(success: false)
            return "\(result):添加失败"
        } else {
            
                //2.添加信息
                //2.1创建entity
                let entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: managedContext)
                //2.2插入值
                let Registertemp = Entity(entity: entity!,insertIntoManagedObjectContext: managedContext)
                Registertemp.setValue(tel, forKey: "tel")
                Registertemp.setValue(password, forKey: "password")
                Registertemp.setValue(image, forKey: "image")
                //2.4保存信息
                do {
                    
                    try managedContext.save()
                    let result = handel(success: true)
                    print("\(result):保存信息成功")
                } catch let error as NSError {
                    
                    let  result = handel(success: false)
                    print("\(result)，error：\(error):保存信息失败")
                    
                }
            
            return "可以添加"
            
        }
    }
    
}

//MARK:修改密码
func updatePass(tel:String,newPassword:String,confirmPassword:String,handler:(success:Bool)->(String)) {
    
    searchTel(tel) { (success) -> (String) in
        if success {
            
                entity.password = newPassword
                //2.4保存信息
                do {
                    
                    try managedContext.save()
                    let result = handler(success: true)
                    print("\(result):修改信息成功")
                } catch let error as NSError {
                    
                    let  result = handler(success: false)
                    print("\(result)，error：\(error):修改信息失败")
                    
                }
            return "手机号正确"
        } else {
            
            let  result = handler(success: false)
            print("\(result),查找信息失败")
            return "手机号未注册"
        }
    }
    
    
}



