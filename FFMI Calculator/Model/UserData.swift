//
//  UserData.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/10/24.
//

import Foundation
import RealmSwift

class UserData: Object {
    
    @objc dynamic var FFMI: Float = 0.0
    @objc dynamic var AFFMI: Float = 0.0
    @objc dynamic var fat: Float = 0.0
    @objc dynamic var name: String?
    
    // see all
    @objc dynamic var neck: Float = 0.0
    @objc dynamic var waist: Float = 0.0
    @objc dynamic var hip: Float = 0.0
    @objc dynamic var heightFt: Float = 0.0
    @objc dynamic var heightInch: Float = 0.0
    @objc dynamic var weight: Float = 0.0
    
    @objc dynamic var unitImperial: Bool = true
    
    @objc dynamic var date: TimeInterval = 0.0
    
    required convenience init(FFMI: Float, AFFMI: Float, fat: Float, name: String? = nil, neck: Float, waist: Float, hip: Float, heightFt: Float, heightInch: Float, weight: Float, unitImperial: Bool = true, date: TimeInterval) {
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
