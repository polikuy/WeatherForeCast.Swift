//
//  Entity+CoreDataProperties.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/16.
//  Copyright © 2016年 李宇佳. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData


extension Entity {

    @NSManaged var tel: String?
    @NSManaged var password: String?
    @NSManaged var image: String?
    @NSManaged var cityname: String?

}
