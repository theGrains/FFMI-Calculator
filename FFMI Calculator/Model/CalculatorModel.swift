//
//  CalculatorModel.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/5/24.
//

import Foundation

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
    
    func convertMetricToImperialFat() {
        
    }
    
    func calculateBodyFat(_ orientationMale: Bool, _ waist: Float, _ hip: Float, _ neck: Float, _ heightFt: Float, _ heightInch: Float) -> Float {
        
        var fat: Float = 0.0
        
        if orientationMale == true {
            fat = 495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(heightFt * 12 + heightInch)) - 450
        } else {
            fat = 495 / (1.29579 - 0.35004 * log10(waist + hip - neck) + 0.22100 * log10(heightFt * 12 + heightInch)) - 450
        }
        return fat
    }
}
