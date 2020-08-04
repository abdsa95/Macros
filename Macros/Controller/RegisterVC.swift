//
//  RegisterVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 03/07/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //MARK:- Properties
    let identifier = "registerGotoInfo"
    
    
    //MARK:- Register Action
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        if nameTF.text != "" && emailTF.text != "" && passwordTF.text != "" {
          
            AuthService.instacne.registerUser(withEmail: emailTF.text!, andPassword: passwordTF.text!) { (status, error) in
                
                if error != nil {
                    self.alert(title: "Network Error", message: "Error signing up")
                    SVProgressHUD.dismiss()
                } else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: self.identifier, sender: self)
                }
            }
            
        } else {
            alert(title: "Fill all the fields", message: "Please fill all the fields")
            SVProgressHUD.dismiss()
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let infoPageVC = segue.destination as! AuthVC
            infoPageVC.name = nameTF.text ?? ""
            infoPageVC.email = emailTF.text ?? ""
        }
    }
}

//MARK- Extension
extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

