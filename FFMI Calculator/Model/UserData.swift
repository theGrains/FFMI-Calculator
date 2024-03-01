//
//  UserData.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/10/24.
//

import Foundation
import RealmSwift

class UserData: Object {
    
    @objc dynamic var FFMI: String?
    @objc dynamic var AFFMI: String?
    @objc dynamic var fat: String?
    @objc dynamic var name: String?
    
    // see all
    @objc dynamic var neck: String?
    @objc dynamic var waist: String?
    @objc dynamic var hip: String?
    @objc dynamic var heightFt: String?
    @objc dynamic var heightInch: String?
    @objc dynamic var weight: String?
    
    @objc dynamic var unitImperial: Bool = true
    
    @objc dynamic var date: TimeInterval = 0.0
    
    required convenience init(FFMI: String? = nil, AFFMI: String? = nil, fat: String? = nil, name: String? = nil, neck: String? = nil, waist: String? = nil, hip: String? = nil, heightFt: String? = nil, heightInch: String? = nil, weight: String? = nil, unitImperial: Bool = true, date: TimeInterval = 0.0) {
        self.init()
        self.FFMI = FFMI
        self.AFFMI = AFFMI
        self.fat = fat
        self.name = name
        self.neck = neck
        self.waist = waist
        self.hip = hip
        self.heightFt = heightFt
        self.heightInch = heightInch
        self.weight = weight
        self.unitImperial = unitImperial
        self.date = date
    }
}
