//
//  WeekBriefsVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 26/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import Firebase
import MBCircularProgressBar


class WeekBriefsVC: UIViewController {

    
    
    //MARK:- Outlets
    @IBOutlet weak var sunProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var monProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var tuesProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var wedProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var thrsProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var friProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var satProgressBar: MBCircularProgressBarView!

    
    //MARK:- Properties
    var calsNumber = 0.0
    var calsNeed = 0.0
    
    
    //MARK:- Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserCalsNeeded()
        setCals()
    }
    
    func setCals(){
        getuserCalsForDay(day: "Sunday")
        getuserCalsForDay(day: "Monday")
        getuserCalsForDay(day: "Tuesday")
        getuserCalsForDay(day: "Wednesday")
        getuserCalsForDay(day: "Thursday")
        getuserCalsForDay(day: "Friday")
        getuserCalsForDay(day: "Saturday")
    }
    
    
    //MARK:- Networking
    func getUserCalsNeeded(){
       
        DataService.instance.getUserCals(uid: Auth.auth().currentUser?.uid ?? "") { (returnedCla) in
            self.calsNeed = returnedCla
        }
        
    }
    
    
    
    
    
    func getuserCalsForDay(day: String){
        
        DataService.instance.getUserClaoires(uid: Auth.auth().currentUser?.uid ?? "" , day: day) { (returendCals) in
            
            self.calsNumber = Double(returendCals) ?? 0.0
            let precent = self.calsNumber / self.calsNeed * 100
            
            switch day {
                
            case "Sunday": self.sunProgressBar.value = CGFloat(precent)
                break
                
            case "Monday": self.monProgressBar.value = CGFloat(precent)
                break
                
            case "Tuesday": self.tuesProgressBar.value = CGFloat(precent)
                break
                
            case "Wednesday": self.wedProgressBar.value = CGFloat(precent)
                break
                
            case "Thursday": self.thrsProgressBar.value = CGFloat(precent)
                break
                
            case "Friday": self.friProgressBar.value = CGFloat(precent)
                break
                
            case "Saturday": self.satProgressBar.value = CGFloat(precent)
                break
                
            default:
                print("Error")
            }
            
        }
    }
}
