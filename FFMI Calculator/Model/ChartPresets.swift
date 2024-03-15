//
//  chartPresets.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/20/24.
//

import Foundation
import UIKit
import DGCharts
import RealmSwift

struct ChartPresets {
        
    static func lineChartPreset(_ userData: Results<UserData>, _ lineChartView: LineChartView, _ plotType: String) {
        
        lineChartView.backgroundColor = UIColor.regularGreen
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.leftAxis.labelTextColor = .darkBlue
        lineChartView.leftAxis.axisLineColor = .darkGreen
        lineChartView.leftAxis.labelPosition = .outsideChart
        
        switch plotType { // may want to change this by checking maximum and minimum values
        case "FFMI":
            lineChartView.leftAxis.axisMaximum = 40
            lineChartView.leftAxis.axisMinimum = 10
        case "AFFMI":
            lineChartView.leftAxis.axisMaximum = 40
            lineChartView.leftAxis.axisMinimum = 10
        case "Fat %":
            lineChartView.leftAxis.axisMaximum = 35
            lineChartView.leftAxis.axisMinimum = 0
        case "Weight":
            lineChartView.leftAxis.axisMaximum = 300
            lineChartView.leftAxis.axisMinimum = 50
        default:
            lineChartView.leftAxis.axisMaximum = 40
            lineChartView.leftAxis.axisMinimum = 10
        }
       
        
        if userData.count >= 8 {
            lineChartView.xAxis.setLabelCount(8, force: true)
        } else {
            lineChartView.xAxis.setLabelCount(userData.count, force: true)
        }
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.xAxis.axisLineColor = .darkGreen
        lineChartView.xAxis.axisMaxLabels = 8
        lineChartView.xAxis.axisMinimum = 0
        lineChartView.extraRightOffset = 30
        
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
    }
    
    static func lineChartSetPreset(_ set: LineChartDataSet) {
        
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.valueFont = UIFont(name: "Verdana", size: 10)!
        set.setCircleColor(UIColor.seaGreen)
        set.circleHoleColor = UIColor.white
        set.valueTextColor = UIColor.seaGreen
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(UIColor.seaGreen)
        set.highlightLineWidth = 1
        set.highlightColor = UIColor.seaGreen
        set.highlightLineDashLengths = [10.0]
        
        let gradientColors = [UIColor.seaGreen.cgColor, UIColor.seaGreen.cgColor, UIColor.regularGreen.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.25, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        set.drawFilledEnabled = true
    }
}
