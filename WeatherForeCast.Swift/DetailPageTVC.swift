//
//  DetailPageTVC.swift
//  WeatherForeCast.Swift
//
//  Created by 李宇佳 on 16/6/5.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit

typealias bibaoVaule = (value:Array<String>)->Void

class DetailPageTVC: UITableViewController {
    
    var arr_MaxT : Array<String> = []
    var arr_MinT : Array<String> = []
    var cityName:String?
    var backGroundName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("^^^^^\(arr_MaxT)")
        print("+++++\(arr_MinT)")
        self.tableView.backgroundView = UIImageView.init(image: UIImage.init(named: backGroundName))
        self.navigationItem.title = cityName
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        if arr_MaxT.count != 0 {
            
            let num = arr_MaxT[indexPath.section]
            if num == arr_MaxT[0] {
                
                let cell1  = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
                cell1.textLabel?.numberOfLines = 0
                cell1.textLabel?.text = "今日最高温度：\(arr_MaxT[1]) 最低温度：\(arr_MinT[1])"
                cell1.imageView?.image = imageViewFunc(Int(arr_MaxT[1])!, minImageStr: Int(arr_MinT[1])!)
                return cell1
                
            } else if num == arr_MaxT[1] {
                
                let cell2  = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath)
                cell2.textLabel?.numberOfLines = 0
                cell2.textLabel?.text = "明日最高温度：\(arr_MaxT[4]) 最低温度：\(arr_MinT[4])"
                cell2.imageView?.image = imageViewFunc(Int(arr_MaxT[4])!, minImageStr: Int(arr_MinT[4])!)
                return cell2
                
            } else {
                
                let cell3  = tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath)
                cell3.textLabel?.numberOfLines = 0
                cell3.textLabel?.text = "后天最高温度：\(arr_MaxT[7]) 最低温度：\(arr_MinT[7])"
                cell3.imageView?.image = imageViewFunc(Int(arr_MaxT[7])!, minImageStr: Int(arr_MinT[7])!)
                return cell3
                
            }
        } else {
            
            let cell1  = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
            cell1.textLabel?.text = "请选择城市我才能显示哦"
            return cell1
        }
        
    }
    
    func imageViewFunc(maxImageStr:Int,minImageStr:Int)->UIImage{
        //设置图片
        if  maxImageStr >= 30 && minImageStr > 20{
            let  image = UIImage.init(named: "temperature-weather-ic_128")
            return image!
        } else if maxImageStr < 30 && maxImageStr >= 10{
            let image = UIImage.init(named: "sun-smile-glasses-icon_128")
            return image!
        } else {
            let image = UIImage.init(named: "snow-snowflakes-icon_128")
            return image!
        }
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
