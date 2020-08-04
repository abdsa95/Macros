//
//  Toolbar.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 28/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createToolbar(tf: UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = Colors.customRed
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dissmissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        tf.inputAccessoryView = toolbar
        
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
}

