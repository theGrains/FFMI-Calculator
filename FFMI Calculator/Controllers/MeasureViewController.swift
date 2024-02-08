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
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var knowFatButton: UIButton!
    @IBOutlet weak var dontKnowFatButton: UIButton!
    @IBOutlet weak var imperialButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var trendsButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fieldArray: [UITextField] = [heightFtField, heightInchField, weightField, fatField, neckField, waistField, hipField]
        
        self.delegateDoneField(fieldArray)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        maleButton.isHidden = true
        femaleButton.isHidden = true
        knowFatButton.backgroundColor = UIColor.darkGreen
        dontKnowFatButton.backgroundColor = UIColor.seaGreen
        imperialButton.backgroundColor = UIColor.darkGreen
        metricButton.backgroundColor = UIColor.seaGreen
        maleButton.backgroundColor = UIColor.darkGreen
        femaleButton.backgroundColor = UIColor.seaGreen
        
        let buttonArray: [UIButton] = [maleButton, femaleButton, knowFatButton, dontKnowFatButton, imperialButton, metricButton, calculateButton, resetButton, saveButton, measureButton, trendsButton, methodologyButton, settingsButton]
        
        self.borderButtons(buttonArray)
        
    }
    
    func borderButtons(_ buttonArray: [UIButton]) {
        for button in buttonArray {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.darkGreen.cgColor
        }
    }
    
    func delegateDoneField(_ fieldArray: [UITextField]) {
        for txt in fieldArray {
            txt.delegate = self
            txt.addDoneButtonOnKeyboard()
        }
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
        
        knowFat = true
        maleButton.isHidden = true
        femaleButton.isHidden = true
        neckField.isHidden = true
        hipField.isHidden = true
        waistField.isHidden = true
        fatField.isHidden = false
        knowFatButton.backgroundColor = UIColor(named: "darkGreen")
        dontKnowFatButton.backgroundColor = UIColor(named: "seaGreen")
        
    }
    
    @IBAction func unknownFatPressed(_ sender: UIButton) {
        
        knowFat = false
        maleButton.isHidden = false
        femaleButton.isHidden = false
        neckField.isHidden = false
        hipField.isHidden = false
        waistField.isHidden = false
        fatField.isHidden = true
        knowFatButton.backgroundColor = UIColor(named: "seaGreen")
        dontKnowFatButton.backgroundColor = UIColor(named: "darkGreen")
    }
    
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        orientationMale = true
        maleButton.backgroundColor = UIColor(named: "darkGreen")
        femaleButton.backgroundColor = UIColor(named: "seaGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        orientationMale = false
        maleButton.backgroundColor = UIColor(named: "seaGreen")
        femaleButton.backgroundColor = UIColor(named: "darkGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func imperialButtonPressed(_ sender: UIButton) {
        
        unitsImperial = true
        heightInchField.isHidden = false
        heightFtField.placeholder = "height (ft)"
        heightInchField.placeholder = "height (inch)"
        weightField.placeholder = "weight (lbs)"
        neckField.placeholder = "neck (inch)"
        hipField.placeholder = "hip (inch)"
        waistField.placeholder = "waist (inch)"
        imperialButton.backgroundColor = UIColor(named: "darkGreen")
        metricButton.backgroundColor = UIColor(named: "seaGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func metricButtonPressed(_ sender: UIButton) {
        
        unitsImperial = false
        heightInchField.isHidden = true
        heightFtField.placeholder = "height (cm)"
        weightField.placeholder = "mass (kg)"
        neckField.placeholder = "neck (cm)"
        hipField.placeholder = "hip (cm)"
        waistField.placeholder = "waist (cm)"
        imperialButton.backgroundColor = UIColor(named: "seaGreen")
        metricButton.backgroundColor = UIColor(named: "darkGreen")
        resetButtonPressed(sender)
    }
    
    func animateButton(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        heightFtField.text = ""
        heightInchField.text = ""
        weightField.text = ""
        fatField.text = ""
        waistField.text = ""
        hipField.text = ""
        neckField.text = ""
        ffmiLabel.text = "FFMI ="
        affmiLabel.text = "Normalized FFMI ="
        fatLabel.text = "Fat % ="
        
        if sender.currentTitle == "Reset" {
            animateButton(sender)
        }
    }
    
  
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        //MARK: - Known Fat, Metric Units
        animateButton(sender)

        if knowFat == true {
            if unitsImperial == false {
                if let weightKg = Float(weightField.text!), let heightCm = Float(heightFtField.text!), let fat = Float(fatField.text!) {
                    
                    let data = calculatorModel.convertMetricToImperialFFMI(heightCm, weightKg)
                    let FFMIS = calculatorModel.calculateFFMI(data[0], data[1], data[2], fat)
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                }
                
            //MARK: - Known Fat, Imperial Units

            } else if unitsImperial == true {
                if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let fat = Float(fatField.text!) {
                    
                    let FFMIS = calculatorModel.calculateFFMI(heightFt, heightInch, weight, fat)
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                }
            }
            
        //MARK: - Unknown Fat, Metric Units

        } else if knowFat == false {
            if unitsImperial == false {
                if let weightKg = Float(weightField.text!), let heightCm = Float(heightFtField.text!), let waistCm = Float(waistField.text!), let hipCm = Float(hipField.text!), let neckCm = Float(neckField.text!) {
                    
                    let imperial = calculatorModel.convertMetricToImperialFat(orientationMale, waistCm, neckCm, hipCm)
                    let data = calculatorModel.convertMetricToImperialFFMI(heightCm, weightKg)
                    let fat = calculatorModel.calculateBodyFat(orientationMale, imperial[0], imperial[1], imperial[2], data[0], data[1])
                    let FFMIS = calculatorModel.calculateFFMI(data[0], data[1], data[2], fat)
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                }
                
            //MARK: - Unknown Fat, Imperial Units

            } else if unitsImperial == true {
                if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let waist = Float(waistField.text!), let hip = Float(hipField.text!), let neck = Float(neckField.text!) {
                    
                    let fat = calculatorModel.calculateBodyFat(orientationMale, waist, neck, hip, heightFt, heightInch)
                    let FFMIS = calculatorModel.calculateFFMI(heightFt, heightInch, weight, fat)
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                }
            }
        }
    }
}

extension MeasureViewController: UITextFieldDelegate {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    
    @IBInspectable var doneAccessory: Bool{
            get{
                return self.doneAccessory
            }
            set (hasDone) {
                if hasDone{
                    addDoneButtonOnKeyboard()
                }
            }
        }
    
    func addDoneButtonOnKeyboard() {
           let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
           doneToolbar.barStyle = .default
           
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
           
           let items = [flexSpace, done]
           doneToolbar.items = items
           doneToolbar.sizeToFit()
           
           self.inputAccessoryView = doneToolbar
       }
       
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
