//
//  ViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 3/26/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var trendsButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        tableView.register(UINib(nibName: "UsernameCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = self
        tableView.delegate = self
        
//        let VCButtonArray: [UIButton] = [measureButton, trendsButton, methodologyButton]
//        K.ChangeBorder.borderVCButtons(VCButtonArray)
    }
    
//    @IBAction func VCbuttonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "settingsTo\(sender.currentTitle!)", sender: self)
//    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! UsernameCell
        cell.usernameTextField.text = defaults.string(forKey: "Username")
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
