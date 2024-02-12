//
//  UserData.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/10/24.
//

import Foundation
import RealmSwift

class UserData: Object {
    
    @objc dynamic var FFMI: String? = ""
    @objc dynamic var AFFMI: String? = ""
    @objc dynamic var fat: String? = ""
    @objc dynamic var name: String = ""
    
    // see all
    @objc dynamic var neck: String? = ""
    @objc dynamic var waist: String? = ""
    @objc dynamic var hip: String? = ""
    @objc dynamic var heightFt: String? = ""
    @objc dynamic var heightInch: String? = ""
    @objc dynamic var weight: String? = ""
    
    @objc dynamic var date: TimeInterval = 0.0
    
}
