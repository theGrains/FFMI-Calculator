//
//  CalculatorModel.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/5/24.
//

import Foundation
import UIKit

struct CalculatorModel {
    
    func convertMetricToImperialFFMI (_ heightCm: Float, _ weightKg: Float) -> [Float] {
        
        let inches = round(heightCm * 0.393701)
        let heightFt = floor(inches / 12.0)
        let heightInch = Float(Int(inches) % 12)
        
        let weight = weightKg * 2.20462
        
        return [heightFt, heightInch, weight]
    }
    
    func calculateFFMI(_ heightFt: Float, _ heightInch: Float, _ weight: Float, _ fat: Float) -> [Float] {
        
        let FFMI = ((weight - weight * (fat / 100)) / 2.2) / pow(((heightFt * 12.0 + heightInch) * 0.0254), 2)
        let AFFMI = FFMI + (6.3*(1.8-(heightFt * 12.0 + heightInch)*0.0254))
        return [FFMI, AFFMI]
    }
    
    func convertMetricToImperialFat(_ orientationMale: Bool, _ waist: Float, _ neck: Float, _ hip: Float?) -> [Float] {
        
        var hipInch = hip ?? 0
        let waistInch = waist * 0.393701
        let neckInch = neck * 0.393701
        if orientationMale == false {
            hipInch = hip! * 0.393701
        }
        return [waistInch, neckInch, hipInch]
    }
    
    func calculateBodyFat(_ orientationMale: Bool, _ waist: Float, _ neck: Float, _ hip: Float?, _ heightFt: Float, _ heightInch: Float) -> Float {
        
        var fat: Float = 0.0
        
        if orientationMale == true {
            fat = 86.01 * log10(waist - neck) - 70.041 * log10(heightFt * 12 + heightInch) + 36.76
        } else {
            fat = 163.205 * log10(waist + hip! - neck) - 97.648 * log10(heightFt * 12 + heightInch) - 78.387
        }
        return fat
    }
    
    func fillInData(_ ffmiLabel: UILabel, _ affmiLabel: UILabel, _ fatLabel: UILabel) {
        
        ffmiLabel.text = "Fill in each data entry"
        affmiLabel.text = "Fill in each data entry"
        fatLabel.text = "Fill in each data entry"
    }
    
    func updateViewController(_ FFMI: Float, _ AFFMI: Float, _ fat: Float, _ ffmiLabel: UILabel, _ affmiLabel: UILabel, _ fatLabel: UILabel) {
        
        let FFMItext = String(format: "%.2f", FFMI)
        ffmiLabel.text = "FFMI = \(FFMItext)"
        
        let AFFMItext = String(format: "%.2f", AFFMI)
        affmiLabel.text = "Adjusted FFMI = \(AFFMItext)"
        
        let fatText = String(format: "%.2f", fat)
        fatLabel.text = "Fat % = \(fatText)%"
    }
}
