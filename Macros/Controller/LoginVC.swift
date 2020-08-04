//
//  LoginVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 02/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    //MARK:- Properties
    let identifier = "gotoHomeVC"
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTF.delegate = self
        passwordTF.delegate = self

    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        if emailTF.text != "" && passwordTF.text != "" {
            AuthService.instacne.loginUser(withEmail: emailTF.text!, andPassword: passwordTF.text!) { (complete, error) in
                
                if error != nil {
                    print(error.debugDescription)
                    self.alert(title: "Networks Error", message: "Error logging in")
                    SVProgressHUD.dismiss()
                }
                
                
                if complete {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: self.identifier, sender: self)
                }
            }
            
        } else {
            self.alert(title: "Fill all the Fields", message: "Please don't leave any field empty")
            SVProgressHUD.dismiss()
        }
       
    }
}




extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
