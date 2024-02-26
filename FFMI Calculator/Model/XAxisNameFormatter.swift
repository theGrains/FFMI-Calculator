//
//  XAxisNameFormatter.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/25/24.
//

import Foundation
import DGCharts

class XAxisNameFormatter: NSObject, AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
