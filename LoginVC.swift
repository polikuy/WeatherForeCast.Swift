//
//  LoginVC.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/14.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var telTextF: UITextField!
    @IBOutlet var passwordTextF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title  = "登录"
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:登录按钮
    @IBAction func loginBtn(sender: AnyObject) {
        
        
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
