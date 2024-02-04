//
//  ViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/2/24.
//

import UIKit

class MeasureViewController: UIViewController {
    
    var orientationMale: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }
  
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
    }
    
}

