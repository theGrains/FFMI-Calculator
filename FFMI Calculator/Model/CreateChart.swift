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
    
    static func setData(_ userData: Results<UserData>, _ lineChartView: CombinedChartView, _ plotType: String) {
        
        var data: [ChartDataEntry] = []
        let title: String = plotType
        var count = 0
        for dp in userData {
            
            switch title {
            case "FFMI":
                data.append(ChartDataEntry(x: Double(count), y: Double(dp.FFMI)))
            case "AFFMI":
                data.append(ChartDataEntry(x: Double(count), y: Double(dp.AFFMI)))
            case "Fat %":
                data.append(ChartDataEntry(x: Double(count), y: Double(dp.fat)))
            case "Weight":
                if dp.unitImperial == true {
                    data.append(ChartDataEntry(x: Double(count), y: Double(dp.weight)))
                } else {
                    data.append(ChartDataEntry(x: Double(count), y: Double(dp.weight * 2.20462)))
                }
            default:
                data.append(ChartDataEntry(x: Double(count), y: Double(dp.FFMI)))
            }
            count += 1
        }
        count = 0
        
        var set = LineChartDataSet(entries: data, label: title)
        if title == "Weight" {
            set = LineChartDataSet(entries: data, label: "Weight (lbs)")
        }
        
        ChartPresets.lineChartSetPreset(set)
        if userData.count > 1 {
            lineChartView.data = LineChartData(dataSet: set)
            lineChartView.data?.setValueFormatter(DefaultValueFormatter(decimals: 2))
        } else if userData.count == 1 {
            lineChartView.data = nil
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            lineChartView.noDataText = "\(title) = \(String(format: "%.2f", data[0].y)), \(dateFormatter.string(from: Date(timeIntervalSince1970: userData[0].date)))"
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
