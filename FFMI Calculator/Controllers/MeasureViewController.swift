//
//  ViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/2/24.
//

import UIKit
import RealmSwift
import SkyFloatingLabelTextField

class MeasureViewController: UIViewController {
    
    var orientationMale: Bool = true
    var unitsImperial: Bool = true
    var knowFat: Bool = true
    var calculatorModel = CalculatorModel()
    let realm = try! Realm()
    let dataArray: [UserData] = []
    var enteredData: Bool = false
    let defaults = UserDefaults.standard
    
    var currentFFMI: Float?
    var currentAFFMI: Float?
    var currentFat: Float?
    
    @IBOutlet weak var heightFtField: SkyFloatingLabelTextField!
    @IBOutlet weak var heightInchField: SkyFloatingLabelTextField!
    @IBOutlet weak var weightField: SkyFloatingLabelTextField!
    @IBOutlet weak var fatField: SkyFloatingLabelTextField!
    @IBOutlet weak var neckField: SkyFloatingLabelTextField!
    @IBOutlet weak var hipField: SkyFloatingLabelTextField!
    @IBOutlet weak var waistField: SkyFloatingLabelTextField!
    
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
    
    
    @IBOutlet weak var orientationStack: UIStackView!
    @IBOutlet weak var bodyStack: UIStackView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        placeholderLabel.isHidden = false
        orientationStack.isHidden = true
        bodyStack.isHidden = true
        knowFatButton.backgroundColor = UIColor.darkGreen
        dontKnowFatButton.backgroundColor = UIColor.seaGreen
        imperialButton.backgroundColor = UIColor.darkGreen
        metricButton.backgroundColor = UIColor.seaGreen
        maleButton.backgroundColor = UIColor.darkGreen
        femaleButton.backgroundColor = UIColor.seaGreen
        
//        let VCButtonArray: [UIButton] = [maleButton, femaleButton, knowFatButton, dontKnowFatButton, imperialButton, metricButton, measureButton, trendsButton, methodologyButton, settingsButton]
//        K.ChangeBorder.borderVCButtons(VCButtonArray)
        
        let optionButtonArray: [UIButton] = [calculateButton, resetButton, saveButton]
        K.ChangeBorder.borderOptionButtons(optionButtonArray)
        
        let fieldArray: [SkyFloatingLabelTextField] = [heightFtField, heightInchField, weightField, fatField, neckField, waistField, hipField]
        K.ChangeBorder.changeTextFields(fieldArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if defaults.string(forKey: "Username") != nil {
            // nothing
        } else {
            
            var textField = UITextField()
            textField.autocapitalizationType = UITextAutocapitalizationType.words
            
            let alert = UIAlertController(title: "No User Found", message: "Please enter your name", preferredStyle: .alert)
            let action = UIAlertAction(title: "Enter", style: .default) { action in
                if textField.text != "" {
                    self.defaults.set(textField.text, forKey: "Username")
                }
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Name"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // viewDidLoad, viewWillAppear, viewDidAppear, viewWillDisappear, viewDidDisappear
    // AppDelegate -> iOS lets us know where we are
    // two windows -> two separate scenes - this is what the scene delegate is for
    // AppDelegate -> launched, receiving time changes
    // SceneDelegate -> window coming into foreground, etc
    // sceneDidEnterBackground -> good time to save user's data
    
//    @IBAction func changeVCButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "measureTo\(sender.currentTitle!)", sender: self)
//    }
    
    @IBAction func knownFatPressed(_ sender: UIButton) {
        
        knowFat = true
        placeholderLabel.isHidden = false
        orientationStack.isHidden = true
        bodyStack.isHidden = true
        fatField.isHidden = false
        knowFatButton.backgroundColor = UIColor(named: "darkGreen")
        dontKnowFatButton.backgroundColor = UIColor(named: "seaGreen")
        
    }
    
    @IBAction func unknownFatPressed(_ sender: UIButton) {
        
        knowFat = false
        hipField.isHidden = true
        placeholderLabel.isHidden = true
        orientationStack.isHidden = false
        bodyStack.isHidden = false
        fatField.isHidden = true
        knowFatButton.backgroundColor = UIColor(named: "seaGreen")
        dontKnowFatButton.backgroundColor = UIColor(named: "darkGreen")
    }
    
    
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        orientationMale = true
        hipField.isHidden = true
        maleButton.backgroundColor = UIColor(named: "darkGreen")
        femaleButton.backgroundColor = UIColor(named: "seaGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func femaleButtonPressed(_ sender: UIButton) {
        orientationMale = false
        hipField.isHidden = false
        maleButton.backgroundColor = UIColor(named: "seaGreen")
        femaleButton.backgroundColor = UIColor(named: "darkGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func imperialButtonPressed(_ sender: UIButton) {
        
        unitsImperial = true
        heightInchField.isHidden = false
        heightFtField.placeholder = "Height (ft)"
        heightInchField.placeholder = "Height (in)"
        weightField.placeholder = "Weight (lbs)"
        neckField.placeholder = "Neck (in)"
        hipField.placeholder = "Hip (in)"
        waistField.placeholder = "Waist (in)"
        imperialButton.backgroundColor = UIColor(named: "darkGreen")
        metricButton.backgroundColor = UIColor(named: "seaGreen")
        resetButtonPressed(sender)
    }
    
    @IBAction func metricButtonPressed(_ sender: UIButton) {
        
        unitsImperial = false
        heightInchField.isHidden = true
        heightFtField.placeholder = "Height (cm)"
        weightField.placeholder = "Mass (kg)"
        neckField.placeholder = "Neck (cm)"
        hipField.placeholder = "Hip (cm)"
        waistField.placeholder = "Waist (cm)"
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
        
        enteredData = false
        heightFtField.text = ""
        heightInchField.text = ""
        weightField.text = ""
        fatField.text = ""
        waistField.text = ""
        hipField.text = ""
        neckField.text = ""
        ffmiLabel.text = "FFMI ="
        affmiLabel.text = "Adjusted FFMI ="
        fatLabel.text = "Fat % ="
        
        if sender.currentTitle == "Reset" {
            animateButton(sender)
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        animateButton(sender)
        
        var realData: Bool = false
        
        if let currentFatOptional = currentFat {
            
            if currentFatOptional >= 0 && currentFatOptional <= 40 && currentFFMI! >= 0 {
                realData = true
            } else {
                realData = false
            }
        }
        
        if enteredData == true && realData == true {
            
            let userData = UserData(FFMI: currentFFMI!, AFFMI: currentAFFMI!, fat: currentFat!, name: defaults.string(forKey: "Username")!, neck: Float(neckField.text!) ?? 0.0, waist: Float(waistField.text!) ?? 0.0, hip: Float(hipField.text!) ?? 0.0, heightFt: Float(heightFtField.text!) ?? 0.0, heightInch: Float(heightInchField.text!) ?? 0.0, weight: Float(weightField.text!) ?? 0.0, unitImperial: unitsImperial, date: Date().timeIntervalSince1970)
            
            do {
                try realm.write {
                    realm.add(userData)
                }
            } catch {
                print("Error saving data, \(error)")
            }
        } else if enteredData == false {
            let alert = UIAlertController(title: "No data to save", message: "Please enter data, click calculate, then click save", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
            calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
        } else if realData == false {
            let alert = UIAlertController(title: "Data may have been entered incorrectly", message: "Please enter data, click calculate, then click save", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
            calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
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
                    currentFFMI = FFMIS[0]
                    currentAFFMI = FFMIS[1]
                    currentFat = fat
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                    let alert = UIAlertController(title: "Lacking data to calculate", message: "Please enter data and click calculate", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true, completion: nil)
                }
                
            //MARK: - Known Fat, Imperial Units

            } else if unitsImperial == true {
                if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let fat = Float(fatField.text!) {
                    
                    let FFMIS = calculatorModel.calculateFFMI(heightFt, heightInch, weight, fat)
                    currentFFMI = FFMIS[0]
                    currentAFFMI = FFMIS[1]
                    currentFat = fat
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                    let alert = UIAlertController(title: "Lacking data to calculate", message: "Please enter data and click calculate", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true, completion: nil)
                }
            }
            
        //MARK: - Unknown Fat, Metric Units

        } else if knowFat == false {
            if unitsImperial == false {
                if let weightKg = Float(weightField.text!), let heightCm = Float(heightFtField.text!), let waistCm = Float(waistField.text!), let neckCm = Float(neckField.text!) {
                    
                    let hipCm = Float(hipField.text!) ?? nil
                    let imperial = calculatorModel.convertMetricToImperialFat(orientationMale, waistCm, neckCm, hipCm)
                    let data = calculatorModel.convertMetricToImperialFFMI(heightCm, weightKg)
                    let fat = calculatorModel.calculateBodyFat(orientationMale, imperial[0], imperial[1], imperial[2], data[0], data[1])
                    let FFMIS = calculatorModel.calculateFFMI(data[0], data[1], data[2], fat)
                    currentFFMI = FFMIS[0]
                    currentAFFMI = FFMIS[1]
                    currentFat = fat
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                    let alert = UIAlertController(title: "Lacking data to calculate", message: "Please enter data and click calculate", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true, completion: nil)
                }
                
            //MARK: - Unknown Fat, Imperial Units

            } else if unitsImperial == true {
                if let weight = Float(weightField.text!), let heightFt = Float(heightFtField.text!), let heightInch = Float(heightInchField.text!), let waist = Float(waistField.text!), let neck = Float(neckField.text!) {
                    
                    let hip = Float(hipField.text!) ?? nil
                    let fat = calculatorModel.calculateBodyFat(orientationMale, waist, neck, hip, heightFt, heightInch)
                    let FFMIS = calculatorModel.calculateFFMI(heightFt, heightInch, weight, fat)
                    currentFFMI = FFMIS[0]
                    currentAFFMI = FFMIS[1]
                    currentFat = fat
                    let FFMI = FFMIS[0]
                    let AFFMI = FFMIS[1]
                    
                    calculatorModel.updateViewController(FFMI, AFFMI, fat, ffmiLabel, affmiLabel, fatLabel)
                } else {
                    calculatorModel.fillInData(ffmiLabel, affmiLabel, fatLabel)
                    let alert = UIAlertController(title: "Lacking data to calculate", message: "Please enter data and click calculate", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        
        if ffmiLabel.text != "Fill in each data entry" {
            enteredData = true
        }
    }
}
