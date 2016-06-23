//
//  WeatherManager.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/16.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit
import CoreData

class WeatherManager: NSObject {
    
    class var shareManager: WeatherManager {
        struct Staitc {
            static var onceToken :dispatch_once_t = 0
            static var instance: WeatherManager? = nil
        }
        dispatch_once (&Staitc.onceToken) {
            Staitc.instance = WeatherManager()
        }
        return Staitc.instance!
    }
    
}

//MARK:天气
func weatherCollect(searchBartext:String,handler:(success:Bool)->(String)) {
    
    //查询是否已保存过该城市
    searchWeather(searchBartext) { (success) -> String in
        if success {
            
            //添加该城市
            //2.添加信息
            //2.1创建entity
            let entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: managedContext)
            //2.2插入值
            let loginTemp = Entity(entity: entity!,insertIntoManagedObjectContext: managedContext)
            loginTemp.setValue(searchBartext, forKey: "cityname")
            //2.4保存信息
            do {
                
                try managedContext.save()
                let result = handler(success: true)
                print("\(result):保存信息成功")
            } catch let error as NSError {
                
                let  result = handler(success: false)
                print("\(result)，error：\(error):保存信息失败")
                
            }

            return "收藏成功"
        } else {
            
            return "收藏失败"
        }
    }
    
    
}

func searchWeather(cityName:String,handler:(success:Bool)->String) -> Void {
    
    if cityName == "" {
        
        let result = handler(success: false)
        print("你未保存城市:\(result)")
    }else {
        
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        managedContext = appdelegate?.managedObjectContext
        
        //2.建立一个获取的请求
        let fetchRequest = NSFetchRequest(entityName:"Entity")
        fetchRequest.predicate = NSPredicate(format: "cityname = \(cityName)")
        
        //3.执行请求
        do {
            
            let temp =  try managedContext?.executeFetchRequest(fetchRequest)as! [NSManagedObject]?
            if temp?.count > 0 {
                
                entity = temp![0] as! Entity
                print("weatherManager中注册的信息为：\(entity)")
                let result = handler(success: false)
                print("已经收藏过了：\(result)")
            } else {
                
                let  result = handler(success: true)
                print("还未收藏：\(result)")
                
            }
            
        } catch let error as NSError {
            print("无法获取数据 error：\(error) ")
            let result = handler(success: false)
            print("无法获取数据：\(result)")
        }
    }

    
}


