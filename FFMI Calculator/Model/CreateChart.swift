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
    
    static func setData(_ userData: Results<UserData>, _ lineChartView: CombinedChartView) {
        
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
        if userData.count > 1 {
            lineChartView.data = LineChartData(dataSet: set)
            lineChartView.data?.setValueFormatter(DefaultValueFormatter(decimals: 2))
        } else if userData.count == 1 {
            lineChartView.data = nil
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            lineChartView.noDataText = "FFMI = \(data[0].y), \(dateFormatter.string(from: Date(timeIntervalSince1970: userData[0].date)))"
        } else if userData.count == 0 {
            lineChartView.data = nil
            lineChartView.noDataText = "There is no data to display"
        }
        if set.count >= 8 {
            lineChartView.setVisibleXRange(minXRange: 7, maxXRange: 7)
        } else {
            lineChartView.setVisibleXRange(minXRange: Double(userData.count), maxXRange: 7)
        }
        lineChartView.moveViewToX(0.0)
    }
}
