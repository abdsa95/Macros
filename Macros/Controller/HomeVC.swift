//
//  HomeVC.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 02/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Firebase

class HomeVC: UIViewController {

    //MARK:- Outlets

    @IBOutlet weak var calsProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var protineLabel: UILabel!
    @IBOutlet weak var calsLabel: UILabel!
    @IBOutlet weak var fatsTF: UITextField!
    @IBOutlet weak var carbsTF: UITextField!
    @IBOutlet weak var protineTF: UITextField!
    @IBOutlet weak var calsTF: UITextField!
    @IBOutlet weak var chooseDayTF: UITextField!
    

    
    //MARK:- Properties
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var calsNumber = 0.0
    var calsNeed = 0.0
    var selectedDay = "Sunday"
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createDaysPicker()
        setToolbar()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserCalsNeeded()
        getUserClas()
    }
    
    func createDaysPicker(){
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        chooseDayTF.inputView = dayPicker
    }
    
    
    func setToolbar(){
        createToolbar(tf: chooseDayTF)
         createToolbar(tf: carbsTF)
         createToolbar(tf: fatsTF)
         createToolbar(tf: protineTF)
         createToolbar(tf: calsTF)
    }
    
    func updateUI(value: CGFloat){
        calsProgressBar.progressColor = Colors.customRed
        UIView.animate(withDuration: 0.8) {
            self.calsProgressBar.value = value
        }
    }
    
    
    @IBAction func carbsAddButtonPressed(_ sender: UIButton) {
        calculateCals(tf: carbsTF, multiplier: 4)
    }
    
    @IBAction func fatsAddButtonPressed(_ sender: UIButton) {
        calculateCals(tf: fatsTF, multiplier: 9)
    }
    
    @IBAction func protineAddButtonPressed(_ sender: UIButton) {
        calculateCals(tf: protineTF, multiplier: 4)
    }
    
    @IBAction func calsAddButtonPressed(_ sender: UIButton) {
        calculateCals(tf: calsTF, multiplier: 1)
    }
    
    func calculateCals(tf: UITextField, multiplier: Double){
        if tf.text != "" {
            let minirals = Double(tf.text!)
            let calsOfMinirals = minirals! * multiplier
            calsNumber += calsOfMinirals
            let precent = calsNumber / calsNeed * 100
            self.updateUI(value: CGFloat(precent))
            self.updateUserCals(cals: calsNumber)
            print(calsNumber)
        } else {
            alert(title: "Empty field!", message: "please fill the field with vaild data")
        }
    }
    
    
    
    
    
    
    //MARK:- Networing
    
    func getUserCalsNeeded(){
        DataService.instance.getUserCals(uid: Auth.auth().currentUser?.uid ?? "") { (returnedCla) in
            self.calsNeed = returnedCla
        }
    }
    
    func updateUserCals(cals: Double){
        DataService.instance.updateUesrCals(uid: Auth.auth().currentUser?.uid ?? "", cals: "\(cals)", day: selectedDay) { (error) in
            if error != nil {
                self.alert(title: "Network Error", message: "Error submitting data")
            }
        }
    }
    
    
    func getUserClas(){
        DataService.instance.getUserClaoires(uid: Auth.auth().currentUser?.uid ?? "", day: selectedDay) { (returendCals) in
            self.calsNumber = Double(returendCals) ?? 0.0
            let precent = self.calsNumber / self.calsNeed * 100
            self.updateUI(value: CGFloat(precent))
        }
    }
}



//MARK:- Extension

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseDayTF.text = days[row]
        selectedDay = days[row]
        updateUI(value: 0.0)
        calsNumber = 0.0
        getUserClas()
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = .white
        let attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor : Colors.customRed])
        return attributedString
    }
}
