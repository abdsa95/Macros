//
//  ProfileVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 02/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    //MARK:- Properties
    var bmi: Double!
    
    
    
    //MARK:- Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileImage.layer.cornerRadius = 70.0
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = Colors.customRed.cgColor
        profileImage.layer.masksToBounds = true
        
        fetchData()
    }
    
    
    
    
    func calculateBMI(height: Double,weight: Double){
       
        //in case the user input the height in centimeter 
        var newHeight = height
        if height > 10 {
            newHeight /= 100
        }
        
        bmiLabel.adjustsFontSizeToFitWidth = true
        let bmi = weight / (newHeight * newHeight)
         print(bmi)
        if bmi < 18.5 {
            bmiLabel.text = "underweight"
        } else if bmi >= 18.5 && bmi <= 24.9 {
            bmiLabel.text = "healthy"
        } else if bmi >= 25 && bmi <= 29.9 {
            bmiLabel.text = "overweight"
        } else if bmi >= 30 {
            bmiLabel.text = "obesity"
        } else {
            bmiLabel.text = "--"
        }
        
    }
    
    
    func calculateWaterNeeds(weight: Double, age: Double){
    
        let BWTC = (((weight * age) / 28.3) / 8)
        let BWTCformatted = String(format: "%.f", BWTC)
        waterLabel.text = "You need to drink \(BWTCformatted) cups of water daily"
        waterLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    //MARK:- Fetch Data
    func fetchData(){
        DataService.instance.getUserData(uid: "\(Auth.auth().currentUser?.uid ?? "")") { (returnedUser) in
            
            let height = Double(returnedUser.height) ?? 0
            let weight = Double(returnedUser.weight) ?? 0
            let age = Double(returnedUser.age) ?? 0
            
            
            self.nameLabel.text = returnedUser.name 
            self.caloriesLabel.text = returnedUser.cals
            self.calculateBMI(height: height, weight: weight)
            self.calculateWaterNeeds(weight: weight, age: age)
            
        }
    }
    
    
    
    
    //MARK:- Signout
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            
            do{
                
                try Auth.auth().signOut()
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                self.present(loginVC!, animated: true, completion: nil)
                
            } catch{
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
        
    }
}




