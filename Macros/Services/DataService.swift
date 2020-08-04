//
//  DataService.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 01/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()
class DataService {
    
    static let instance = DataService()
    private var _REF_USERS = DB_BASE.child("Users")
    private var _REF_CALS = DB_BASE.child("Cals")
    let weekOfYear = NSCalendar.current.component(.weekOfYear, from: Date())
    
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_CALS: DatabaseReference {
        return _REF_CALS
    }
    
    //MARK:- User
    func createDBUser(uid: String, userData: Dictionary<String,Any>, handler: @escaping(_ error: Error?)->()){
        REF_USERS.child(uid).updateChildValues(userData)
        REF_USERS.child(uid).updateChildValues(userData) { (error, dbreference) in
            
            if error != nil {
                handler(error)
            }
        }
    }
    
   
   
    
    func getUserData(uid: String,handler: @escaping(_ user: User)->()) {
        var user: User!
        REF_USERS.child(uid).observe(.value) { (snapshot) in
            if snapshot.childrenCount != 0{
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            let height = snapshot.childSnapshot(forPath: "height").value as! String
            let weight = snapshot.childSnapshot(forPath: "weight").value as! String
            let gender = snapshot.childSnapshot(forPath: "gender").value as! String
            let age = snapshot.childSnapshot(forPath: "age").value as! String
            let cals = snapshot.childSnapshot(forPath: "cals").value as! String
                user = User(name: name, height: height, weight: weight, gender: gender, age: age, cals: cals)
            handler(user)
        }
        }
    }
    
    
    //TEMPORARY
    func getUserCals(uid: String,handler: @escaping(_ cals: Double)->()) {
        var cals = 0.0
        REF_USERS.child(uid).observe(.value) { (snapshot) in
            if snapshot.childrenCount != 0{
                let cal = snapshot.childSnapshot(forPath: "cals").value as! String
                
                print(cal)
                cals = Double(cal) ?? 0.0
                handler(cals)
            }
        }
    }
    

    
    func updateUesrCals(uid: String, cals: String, day: String,handler: @escaping(_ error: Error?)->()){
        REF_CALS.child(uid).child("\(weekOfYear)").child(day).updateChildValues(["cals": cals]) { (error, dbreference) in
            
            if error != nil {
                handler(error)
            }
        }
    }
    
    
    func getUserClaoires(uid: String, day:String ,handler: @escaping(_ cals: String)->()){
        REF_CALS.child(uid).child("\(weekOfYear)").child(day).observe(.value) { (snapshot) in
            if snapshot.childrenCount != 0 {
            
                let cals = snapshot.childSnapshot(forPath: "cals").value as! String
                print(cals,"calscalscals")
                handler(cals)
            }
            
        }
    }
}
