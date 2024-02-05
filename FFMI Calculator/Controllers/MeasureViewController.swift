//
//  ViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/2/24.
//

import UIKit

class MeasureViewController: UIViewController {
    
    var orientationMale: Bool = true
    
    @IBOutlet weak var heightFtField: UITextField!
    @IBOutlet weak var heightInchField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var ffmiLabel: UILabel!
    @IBOutlet weak var affmiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightFtField.delegate = self
        heightInchField.delegate = self
        weightField.delegate = self
        fatField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        orientationMale = true
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        orientationMale = false
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
        
        if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let fat = Float(fatField.text!) {
            let FFMI = ((weight - weight * (fat / 100)) / 2.2) / pow(((heightFt * 12.0 + heightInch) * 0.0254), 2)
            let FFMItext = String(format: "%.2f", FFMI)
            ffmiLabel.text = "FFMI = \(FFMItext)"
            
            let AFFMI = FFMI + (6.3*(1.8-(heightFt * 12.0 + heightInch)*0.0254))
            let AFFMItext = String(format: "%.2f", AFFMI)
            affmiLabel.text = "Normalized FFMI = \(AFFMItext)"
        } else {
            ffmiLabel.text = "Fill in each data entry"
        }
    }
}

extension MeasureViewController: UITextFieldDelegate {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
