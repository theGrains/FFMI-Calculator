//
//  CreateChart.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/20/24.
//

import Foundation
import UIKit
import DGCharts
import RealmSwift

class CreateChart {
    
    static func setData(_ userData: Results<UserData>, _ lineChartView: LineChartView) {
        
        var data: [ChartDataEntry] = []
        var count = 0
        for dp in userData {
            let FFMIvalue = dp.FFMI!.index(dp.FFMI!.endIndex, offsetBy: -5)..<dp.FFMI!.endIndex
            data.append(ChartDataEntry(x: Double(count), y: Double(dp.FFMI![FFMIvalue])!))
            count += 1
        }
        count = 0
        
        let set = LineChartDataSet(entries: data, label: "FFMI")
        ChartPresets.lineChartSetPreset(set)
        lineChartView.data = LineChartData(dataSet: set)
        // the following two need to be after this line
        if set.count >= 8 {
            lineChartView.setVisibleXRange(minXRange: 7, maxXRange: 7)
        } else {
            lineChartView.setVisibleXRange(minXRange: Double(set.count), maxXRange: 7)
        }
        
        lineChartView.moveViewToX(Double(userData.count-1))
    }
}
