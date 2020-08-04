//
//  AuthService.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 01/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class AuthService {
    
    static let instacne = AuthService()
    
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status : Bool, _ error: Error?) ->()) {
        
        //SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                userCreationComplete(false,error)
            }
            else {
                userCreationComplete(true,nil)
                print ("Registration Successful!")
                
            }
            
        })
        //SVProgressHUD.dismiss()
    }
    
    
    func loginUser(withEmail email: String, andPassword password: String, userLoginComplete: @escaping (_ status: Bool, _ error: Error?) -> () ){
        
        //SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                userLoginComplete(false, error)
                return
            }
            userLoginComplete(true,nil)
        }
        //SVProgressHUD.dismiss()
    }
    
}
