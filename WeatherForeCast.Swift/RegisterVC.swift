//
//  RegisterVC.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/14.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit
import CoreData
class RegisterVC: UIViewController {
    
    @IBOutlet var headImageV: UIImageView!
    @IBOutlet var telTextF: UITextField!
    @IBOutlet var passwordTextF: UITextField!
    @IBOutlet var passwordTwotextF: UITextField!
    @IBOutlet var safeCodeTextF: UITextField!
    @IBOutlet var sendCodeL: UILabel!
    @IBOutlet var telDetailL: UILabel!
    @IBOutlet var passwordDetail: UILabel!
    
    var array :[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title  = "注册"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtn(sender: AnyObject) {
        
        //MARK：手机号码的正则匹配
        let pattern = "1[3|5|7|8][0-9]\\d{8}"
        let tel_temp = self.telTextF.text?.rangeOfString(pattern, options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
        print(tel_temp?.count)
        
        if  tel_temp?.count != 11 {
            
            self.telDetailL.text = "手机号格式不正确"
            self.telDetailL.backgroundColor = UIColor.redColor()
        } else if self.passwordTextF.text != self.passwordTwotextF.text {
            
            self.passwordDetail.text = "密码不一致"
            self.passwordDetail.backgroundColor = UIColor.redColor()
        } else {
            
            register(self.telTextF.text!, password: self.passwordTextF.text!, confirmPassword: self.passwordTwotextF.text!, image: "", handel: { (success) -> (String) in
                
                if success {
                    
                    self.telDetailL.text = ""
                    self.telDetailL.backgroundColor = UIColor.clearColor()
                    self.passwordDetail.text = ""
                    self.passwordDetail.backgroundColor = UIColor.clearColor()
                    //跳转至登录界面
                    self.navigationController?.popViewControllerAnimated(true)
                    return "注册成功"
                } else {
                    
                    self.telDetailL.text = "已注册"
                    self.telDetailL.backgroundColor = UIColor.redColor()
                    return "注册失败"
                }
                
            })
            
        }
        
        
        
               
    }
    
    @IBAction func cancelBtn(sender: AnyObject) {
        
        
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
