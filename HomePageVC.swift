//
//  HomePageVC.swift
//  WeatherForeCast.Swift
//
//  Created by 李宇佳 on 16/6/5.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController
{
    @IBOutlet var barBtnItem: UIBarButtonItem!
    @IBOutlet var backGroundImageV: UIImageView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var maxImage: UIImageView!
    @IBOutlet var cityL: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var weatherSummaryL: UILabel!
    @IBOutlet var scrollerView: UIScrollView!
    var searchBarText: String!
    var str_weatherSummary:String!
    var backImageStr :String!
    
    
    var max_marr :Array<String> = []
    var min_marr :Array<String> = []
    var maxTemp_arr : Array<String> = []
    var minTemp_arr : Array<String> = []
    var arr_MinTemp :Array<String> = []
    var arr_MaxTemp :Array<String> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Reach().monitorReachabilityChanges()
        //创建通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.interNet(_:)), name: ReachabilityStatusChangedNotification, object: nil)
        searchBar.placeholder = "请输入城市名"
        backImageStr = "backGround"
        barBtnItem.image = UIImage.init(named: "night-clouds-moon-icon_128")
        self.pleaseWait()
        weather("Beijing")
        
        
    }
    
    func interNet(noti:NSNotification){
        
        let  temp_str = noti.userInfo!["Status"]!
        if temp_str as! String == "Online (WiFi)" {
            tip("已连接网络，当前网络为WIFI")
        } else if temp_str as! String == "Online (WWAN)"{
            tip("已连接网络，当前网络为3G")
        }else {
            tip("未连接网络")
        }
        //移除通知
        NSNotificationCenter.defaultCenter().removeObserver(noti)
    }
     //收藏按钮
    @IBAction func collectBtn(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC")
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
        
    }
    //MARK:搜索按钮
    @IBAction func searchBtnClick(sender: AnyObject) {
        
        //设置searchBar出现空的提示
        if searchBar.text!.isEmpty {
            
            let tipStr = "请正确输入城市名"
            tip(tipStr)
            
        } else if ((searchBar.text?.rangeOfString(" ")) != nil ){
            
            self.searchBarText = searchBar.text?.stringByReplacingOccurrencesOfString(" ", withString: "")
            weather(searchBarText)
            
        } else {
            //调用函数
            self.searchBarText = searchBar.text
            self.pleaseWait()
            self.weather(self.searchBarText)
            
        }
        
    }
    
    //MARK:天气函数
    func weather(searchBarText:String) -> Void {
        
        var tempCity = searchBarText
        
        if searchBarText == "Qingdao" || searchBarText == "qingdao" {
            
            tempCity = "Tsingtao"
        } else if tempCity.containsString("y") {
            
            tempCity = tempCity.stringByReplacingOccurrencesOfString("y", withString: "Y")
        }
        
        let str = "http://www.weather-forecast.com/locations/\(tempCity)/forecasts/latest"
        
        //创建url
        let urlStr = str
        let url = NSURL(string: urlStr)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!){ (data, response, error) in
            
            if data != nil{
                
                let str = String(data: data!, encoding: NSUTF8StringEncoding)
                
                //截取字符串 获取weather summary
                var array = str?.componentsSeparatedByString("</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if array?.count < 2 {
                    
                    self.tip("输入城市名字有误，请重新输入")
                    self.clearAllNotice()
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.cityL.text = "城市：\(tempCity)"
                        let strSummary = array![1]
                        let arraySummary = strSummary.componentsSeparatedByString("</span>")
                        self.str_weatherSummary = arraySummary[0]
                        if (self.str_weatherSummary.rangeOfString("&deg;C") != nil) {
                            
                            self.str_weatherSummary = self.str_weatherSummary.stringByReplacingOccurrencesOfString("&deg;C", withString: "°C")
                            self.weatherSummaryL.text! = self.str_weatherSummary!
                        }
                        //获取最高温度最低温度
                        self.temperature(str!)
                        self.clearAllNotice()
                        
                    })
                }
            }
        }
        task.resume()
    }
    
    //MARK:最高温度与最低温度
    func temperature(str:String) -> Void {
        dispatch_async(dispatch_get_main_queue()) {
            
            let array3 = str.componentsSeparatedByString("Max.&nbsp;Temp<span class=\"not_in_print\"><br /></span>(<span class=\"tempu\">C</span>)</div></th>")
            var str_tempM = array3[1]
            
            for var index in 0...5{
                
                index += 1
                str_tempM = str_tempM.stringByReplacingOccurrencesOfString("<td class=\"num_cell dark temp-color\(index)\">", withString: "A")
                str_tempM = str_tempM.stringByReplacingOccurrencesOfString("</span></td>", withString: "A")
            }
            
            //设置最高温度
            str_tempM = str_tempM.stringByReplacingOccurrencesOfString("A<span class=\"temp\">", withString: "A")
            self.arr_MaxTemp = str_tempM.componentsSeparatedByString("</tr>")
            let str_MaxTemp = self.arr_MaxTemp[0]
            self.arr_MaxTemp = str_MaxTemp.componentsSeparatedByString("A")
            
            //设置最低温度
            self.arr_MinTemp = str_tempM.componentsSeparatedByString("Min.&nbsp;Temp<span class=\"not_in_print\"><br /></span>(<span class=\"tempu\">C</span>)</div></th>")
            var str_tempMin = self.arr_MinTemp[1]
            self.arr_MinTemp = str_tempMin.componentsSeparatedByString("</tr>")
            str_tempMin = self.arr_MinTemp[0]
            self.arr_MinTemp = str_tempMin.componentsSeparatedByString("A")
            
            let maxImageStr = Int (self.arr_MaxTemp[1])
            let minImageStr = Int (self.arr_MinTemp[1])
            
            //设置图片
            if  maxImageStr >= 30 && minImageStr > 20{
                self.maxImage.image = UIImage.init(named: "temperature-weather-ic_128")
            } else if maxImageStr < 30 && maxImageStr >= 10{
                self.maxImage.image = UIImage.init(named: "sun-smile-glasses-icon_128")
            } else {
                self.maxImage.image = UIImage.init(named: "snow-snowflakes-icon_128")
            }
            
            //MARK:利用遍历取出所有低温
            for var num = 1; num < self.arr_MinTemp.count; num += 2 {
                self.min_marr.append(self.arr_MinTemp[num])
            }
            //        print("-----minTemp:\(min_marr)-----")
            
            //MARK:利用遍历取出所有高温
            for var num = 1; num < self.arr_MaxTemp.count; num += 2 {
                
                self.max_marr.append(self.arr_MaxTemp[num])
                
            }
            self.maxTemp.text = "最高温度：\(self.max_marr[1])°C 最低温度：\(self.min_marr[1])°C"
            self.maxTemp_arr = self.max_marr
            self.minTemp_arr = self.min_marr
        }
    }
    
    //MARK:night mode
    @IBAction func barBtnItem(sender: AnyObject) {
        
        if barBtnItem.image == UIImage.init(named: "night-clouds-moon-icon_128"){
            
            barBtnItem.image = UIImage.init(named: "sun-smile_barItem")
            backGroundImageV.image = UIImage.init(named: "nightimage.1")
            backImageStr = "nightimage.1"
            
        } else {
            
            barBtnItem.image = UIImage.init(named: "night-clouds-moon-icon_128")
            backGroundImageV.image = UIImage.init(named: "backGround")
            backImageStr = "backGround"
        }
        
    }
    
    
    @IBAction func moreBtn(sender: AnyObject) {
        
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailPageTVC")
        VC.setValue(maxTemp_arr, forKey: "arr_MaxT")
        VC.setValue(minTemp_arr, forKey: "arr_MinT")
        VC.setValue(backImageStr, forKey: "backGroundName")
        VC.setValue(cityL.text, forKey: "cityName")
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    //MARK:网络连接提示
    func internetTip(tip:String) -> Void {
        
        let alertC = UIAlertController.init(title: "提示", message: "已连接网络", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertC.addAction(alertAction)
        self.presentViewController(alertC, animated: true, completion: nil)
    }
    
    //MARK:搜索信息提示消息
    func tip(strTip:String) -> Void {
        
        let alertC = UIAlertController.init(title: "提示", message: strTip, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertC.addAction(alertAction)
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alertC, animated: true, completion: nil)
        }
        
    }
    
}

