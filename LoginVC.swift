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
        loginIn(self.telTextF.text!, password: self.passwordTextF.text!) { (success) -> (String) in
            if success {
                
                self.telTipL.text = ""
                self.passwordTipL.text = ""
                self.telTipL.backgroundColor = UIColor.clearColor()
                self.passwordTipL.backgroundColor = UIColor.clearColor()
                self.loginState = 1
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("HomePageVC")
                vc!.setValue(1, forKey: "loginstate")
                self.navigationController?.popViewControllerAnimated(true)
                return "登录成功"
            } else {
                
                if self.telTextF.text == "" {
                    
                    self.telTipL.backgroundColor = UIColor.redColor()
                    self.telTipL.text = "电话不正确，请重新输入"
                    
                } else if entity.tel != self.telTextF.text {
                    
                    self.telTipL.text = "电话未注册"
                    self.telTipL.backgroundColor = UIColor.redColor()
                } else if entity.password != self.passwordTextF.text {
                    
                    self.passwordTipL.text = "密码不正确，请重新输入"
                    self.passwordTipL.backgroundColor = UIColor.redColor()
                }
                
                return "登录失败"
            }
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
