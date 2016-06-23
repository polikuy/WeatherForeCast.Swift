//
//  ForgetVC.swift
//  天气预报.Swift
//
//  Created by 李宇佳 on 16/6/14.
//  Copyright © 2016年 李宇佳. All rights reserved.
//

import UIKit

class ForgetVC: UIViewController {
    
    @IBOutlet var codeL: UILabel!
    @IBOutlet var safeCode: UITextField!
    @IBOutlet var passwordTwiceTextF: UITextField!
    @IBOutlet var passwordTipL: UILabel!
    @IBOutlet var passwordtextF: UITextField!
    @IBOutlet var telTextF: UITextField!
    @IBOutlet var telTipL: UILabel!
    @IBOutlet var headImageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title  = "重设密码"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:保存按钮
    @IBAction func saveBtn(sender: AnyObject) {
        
        if  self.telTextF.text?.characters.count != 11 {
            
            self.telTipL.text = "手机号格式不正确"
            self.telTipL.backgroundColor = UIColor.redColor()
        } else if self.passwordtextF.text != self.passwordTwiceTextF.text {
            
            self.passwordTipL.text = "密码不一致"
            self.passwordTipL.backgroundColor = UIColor.redColor()
        } else {
            
            updatePass(self.telTextF.text!, newPassword: self.passwordtextF.text!, confirmPassword: self.passwordTwiceTextF.text!) { (success) -> (String) in
                if success {
                    
                    if self.passwordtextF.text != self.passwordTwiceTextF.text {
                        
                        self.passwordTipL.text = "两次输入密码不一致"
                        self.passwordTipL.backgroundColor = UIColor.redColor()
                        return "修改失败"
                    } else {
                        
                        self.passwordTipL.backgroundColor = UIColor.clearColor()
                        self.passwordTipL.text = ""
                        self.telTipL.text = ""
                        self.telTipL.backgroundColor = UIColor.clearColor()
                        self.navigationController?.popViewControllerAnimated(true)
                        return "修改成功"
                    }
                    
                } else {
                    
                    self.telTipL.text = "还未注册"
                    self.telTipL.backgroundColor = UIColor.redColor()
                    return "修改失败"
                }
            }
            
        }
        
    }
    
    //MARK:取消按钮
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
