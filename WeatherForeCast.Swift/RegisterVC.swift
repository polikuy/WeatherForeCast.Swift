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
        
        register(self.telTextF.text!, password: self.passwordTextF.text!, confirmPassword: self.passwordTwotextF.text!, image: "") { (success) -> (String) in
            if success {
                
                self.passwordDetail.backgroundColor = UIColor.clearColor()
                self.passwordDetail.text = ""
                self.telDetailL.text = ""
                self.telDetailL.backgroundColor = UIColor.clearColor()
                self.navigationController?.popViewControllerAnimated(true)
                return ("对")
            } else {
                
                if self.passwordTwotextF.text != self.passwordTextF.text! {
                    
                    self.passwordDetail.backgroundColor = UIColor.redColor()
                    self.passwordDetail.text = "两次密码输入不一致，请重新输入"
                    self.passwordDetail.highlighted = true
                } else {
                    
                    self.telDetailL.backgroundColor = UIColor.redColor()
                    self.telDetailL.text = "手机号码格式不正确，请重新输入"
                    self.telDetailL.highlighted = true
                }
                return ("错")
            }
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
