//
//  LoginVC.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/14.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit
import CoreData


class LoginVC: UIViewController {
    
    @IBOutlet var passwordTipL: UILabel!
    @IBOutlet var telTipL: UILabel!
    @IBOutlet var telTextF: UITextField!
    @IBOutlet var passwordTextF: UITextField!
    var array : [NSManagedObject] = []
    var loginState : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title  = "登录"
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:登录按钮
    @IBAction func loginBtn(sender: AnyObject) {
       
        if  self.telTextF.text?.characters.count != 11 {
            
            self.telTipL.text = "手机号码格式不正确"
            self.telTipL.backgroundColor = UIColor.redColor()
        } else {
            
            loginIn(self.telTextF.text!, password: self.passwordTextF.text!, handler: { (success) -> (String) in
                
                if success {
                    
                    if self.passwordTextF.text != entity.password {
                        
                        self.passwordTipL.text = "密码错误"
                        self.passwordTipL.backgroundColor = UIColor.redColor()
                        return "登录失败"
                    } else {
                        
                    self.telTipL.text = ""
                    self.telTipL.backgroundColor = UIColor.clearColor()
                    self.passwordTipL.text = ""
                    self.passwordTipL.backgroundColor = UIColor.clearColor()
                    self.navigationController?.popViewControllerAnimated(true)
                    return "登录成功"
                    }
                } else {
                    
                        self.telTipL.text = "还未注册"
                        self.telTipL.backgroundColor = UIColor.redColor()
                
                    return "登录失败"
                }
            })
        }
        
        
        
    }
    
    //MARK:注册按钮
    @IBAction func registerBtn(sender: AnyObject) {
        
        let vc  = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterVC")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //MARK：忘记密码按钮
    @IBAction func forgetBtn(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ForgetVC")
        self.navigationController?.pushViewController(vc!, animated: true)
        
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
