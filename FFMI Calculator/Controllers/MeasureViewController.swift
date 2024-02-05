//
//  ViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/2/24.
//

import UIKit

class MeasureViewController: UIViewController {
    
    var orientationMale: Bool = true
    var unitsImperial: Bool = true
    var knowFat: Bool = true
    var calculatorModel = CalculatorModel()
    
    @IBOutlet weak var heightFtField: UITextField!
    @IBOutlet weak var heightInchField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var neckField: UITextField!
    @IBOutlet weak var hipField: UITextField!
    @IBOutlet weak var waistField: UITextField!
    
    
    @IBOutlet weak var ffmiLabel: UILabel!
    @IBOutlet weak var affmiLabel: UILabel!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightFtField.delegate = self
        heightInchField.delegate = self
        weightField.delegate = self
        fatField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        maleButton.isHidden = true
        femaleButton.isHidden = true
        
    }
    
    
    @IBAction func trendsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.measureTrends, sender: self)
    }
    
    @IBAction func methodologyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.measureMethodology, sender: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.measureSettings, sender: self)
    }
    
    @IBAction func knownFatPressed(_ sender: UIButton) {
        
        maleButton.isHidden = true
        femaleButton.isHidden = true
        neckField.isHidden = true
        hipField.isHidden = true
        waistField.isHidden = true
        
    }
    
    @IBAction func unknownFatPressed(_ sender: UIButton) {
        
        maleButton.isHidden = false
        femaleButton.isHidden = false
        neckField.isHidden = false
        hipField.isHidden = false
        waistField.isHidden = false
    }
    
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        orientationMale = true
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        orientationMale = false
    }
    
    @IBAction func imperialButtonPressed(_ sender: UIButton) {
        
        unitsImperial = true
        heightFtField.placeholder = "height (ft)"
        heightInchField.placeholder = "height (inch)"
        weightField.placeholder = "weight (lbs)"
        neckField.placeholder = "circumference (inch)"
        hipField.placeholder = "circumference (inch)"
        waistField.placeholder = "circumference (inch)"
        resetButtonPressed(sender)
    }
    
    @IBAction func metricButtonPressed(_ sender: UIButton) {
        
        unitsImperial = false
        heightFtField.placeholder = "height (cm)"
        heightInchField.placeholder = "N/A"
        weightField.placeholder = "mass (kg)"
        neckField.placeholder = "circumference (cm)"
        hipField.placeholder = "circumference (cm)"
        waistField.placeholder = "circumference (cm)"
        resetButtonPressed(sender)
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        heightFtField.text = ""
        heightInchField.text = ""
        weightField.text = ""
        fatField.text = ""
        ffmiLabel.text = "FFMI ="
        affmiLabel.text = "Normalized FFMI ="
    }
  
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        if unitsImperial == false {
            if let weightKg = Float(weightField.text!), let heightCm = Float(heightFtField.text!), let fat = Float(fatField.text!) {
                
                let data = calculatorModel.convertMetricToImperialFFMI(heightCm, weightKg)
                let FFMIS = calculatorModel.calculateFFMI(data[0], data[1], data[2], fat)
                let FFMI = FFMIS[0]
                let AFFMI = FFMIS[1]
                
                let FFMItext = String(format: "%.2f", FFMI)
                ffmiLabel.text = "FFMI = \(FFMItext)"
                
                let AFFMItext = String(format: "%.2f", AFFMI)
                affmiLabel.text = "Normalized FFMI = \(AFFMItext)"
            } else {
                ffmiLabel.text = "Fill in each data entry"
                affmiLabel.text = "Fill in each data entry"
            }
            
        } else if unitsImperial == true {
            if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let fat = Float(fatField.text!) {
                
                let FFMIS = calculatorModel.calculateFFMI(heightFt, heightInch, weight, fat)
                let FFMI = FFMIS[0]
                let AFFMI = FFMIS[1]
                
                let FFMItext = String(format: "%.2f", FFMI)
                ffmiLabel.text = "FFMI = \(FFMItext)"
                
                let AFFMItext = String(format: "%.2f", AFFMI)
                affmiLabel.text = "Normalized FFMI = \(AFFMItext)"
            } else {
                ffmiLabel.text = "Fill in each data entry"
                affmiLabel.text = "Fill in each data entry"
            }
        }
    }
}

extension MeasureViewController: UITextFieldDelegate {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
