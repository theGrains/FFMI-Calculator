//
//  UsernameCell.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 4/7/24.
//

import UIKit

class UsernameCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        usernameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UsernameCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        defaults.set(usernameTextField.text, forKey: "Username")
    }
}
