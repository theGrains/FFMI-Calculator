//
//  MethodologyViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/3/24.
//

import UIKit

class MethodologyViewController: UIViewController {
    
    
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var trendsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
//        let VCButtonArray: [UIButton] = [measureButton, trendsButton, settingsButton]
//        K.ChangeBorder.borderVCButtons(VCButtonArray)
    }

//    @IBAction func changeVCButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "methodologyTo\(sender.currentTitle!)", sender: self)
//    }
}
