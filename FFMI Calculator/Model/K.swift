//
//  K.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/3/24.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

struct K {
    
    struct Segue {
        
        static let measureTrends = "measureToTrends"
        static let measureMethodology = "measureToMethodology"
        static let measureSettings = "measureToSettings"
        
        static let trendsMeasure = "trendsToMeasure"
        static let trendsMethodology = "trendsToMethodology"
        static let trendsSettings = "trendsToSettings"
        
        static let methodologyMeasure = "methodologyToMeasure"
        static let methodologyTrends = "methodologyToTrends"
        static let methodologySettings = "methodologyToSettings"
        
        static let settingsMeasure = "settingsToMeasure"
        static let settingsTrends = "settingsToTrends"
        static let settingsMethodology = "settingsToMethodology"
    }
    
    struct ChangeBorder {
        
        static func borderVCButtons(_ buttonArray: [UIButton]) {
            for button in buttonArray {
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.darkGreen.cgColor
            }
        }
        
        static func borderOptionButtons(_ buttonArray: [UIButton]) {
            for button in buttonArray {
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.darkGreen.cgColor
            }
        }
        
        static func changeTextFields(_ fieldArray: [SkyFloatingLabelTextField]) {
            for tf in fieldArray {
                tf.titleLabel.textAlignment = .right
                tf.textAlignment = .right
            }
        }
    }
}
