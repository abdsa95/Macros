//
//  AuthVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 01/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class AuthVC: UIViewController {

    //MARK:- Outlets

    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
     @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    //MARK:- Properties
    let identifier = "infoGotoHomeVC"
    var cals = 0.0
    var name: String!
    var email: String!
    
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupButton()
    }


    
    
    //MARK:- Setup TextFields
    func setupTextFields(){
        createToolbar(tf: ageTF)
        createToolbar(tf: weightTF)
        createToolbar(tf: heightTF)
    }

    
    //MARK:- Setup Buttons
    func setupButton(){
        
    }
    
    
    
    //MARK:- calculateCalories
    func calculateClaories(age: Double, weight: Double, height: Double){
        
        let ageInt = Int(age)
        
        if segmentControl.selectedSegmentIndex == 0 {
            calculateCaloriesForMen(age: ageInt, weight: weight, height: height)
        } else if segmentControl.selectedSegmentIndex == 1{
            calculateCloriesForWomen(age: ageInt, weight: weight,  height: height)
        }
        
    }
    
    
    func calculateCloriesForWomen(age: Int, weight: Double, height: Double){
        
        // 10 x (Weight in kg) + 6.25 x(height in cm) - 5 x age - 161
        let weightTimesTen = 10 * weight
        let heightTimesSix = 6.25 * height
        let ageSubtraction = 5 * age - 161
        
        let calsForFemale = weightTimesTen + heightTimesSix - Double(ageSubtraction)
        cals = calsForFemale
        print(calsForFemale)
        
    }
    
    func calculateCaloriesForMen(age: Int, weight: Double, height: Double){
        
        // 10 x (Weight in kg) + 6.25 x(height in cm) - 5 x age + 5
        let weightTimesTen = 10 * weight
        let heightTimesSix = 6.25 * height
        let ageSubtraction = 5 * age + 5
        
        let calsForMale = weightTimesTen + heightTimesSix - Double(ageSubtraction)
        cals = calsForMale
        print(calsForMale)
    }
    
    //MARK:- Networking
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        var gender = ""
        if segmentControl.selectedSegmentIndex == 0 {
 
            gender = "Male"
        } else {
            gender = "Female"
            
        }
            if  ageTF.text != "" && weightTF.text != "" && heightTF.text != "" {
            calculateClaories(age: Double(ageTF.text!) ?? 0, weight: Double(weightTF.text!) ?? 0, height: Double(heightTF.text!) ?? 0)
            let userData = ["name": name ?? "", "email": email ?? "", "age": ageTF.text!, "weight": weightTF.text!, "height": heightTF.text!,"gender": gender, "cals": String(cals)]
                
                DataService.instance.createDBUser(uid: Auth.auth().currentUser?.uid ?? "", userData: userData) { (error) in
                    if error != nil {
                        self.alert(title: "Network Error", message: "Error submitting your data")
                        SVProgressHUD.dismiss()
                    }
                }
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: identifier, sender: self)
                
        } else {
            self.alert(title: "Fill all the fields", message: "Please fill all the fields")
            SVProgressHUD.dismiss()
        }
        
    }


}
//MARK- Extension
extension AuthVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}




