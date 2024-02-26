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
        
    static func lineChartPreset(_ lineChartView: LineChartView, _ userData: Results<UserData>, _ xFormatter: XAxisNameFormatter) {
        
        lineChartView.backgroundColor = UIColor.regularGreen
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.leftAxis.labelTextColor = .darkBlue
        lineChartView.leftAxis.axisLineColor = .darkGreen
        lineChartView.leftAxis.labelPosition = .outsideChart
        // could need to change these two depending on the possibility of values
        lineChartView.leftAxis.axisMaximum = 40
        lineChartView.leftAxis.axisMinimum = 10
        
        if userData.count >= 8 {
            lineChartView.xAxis.setLabelCount(8, force: true)
        } else {
            lineChartView.xAxis.setLabelCount(userData.count, force: true)
        }
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12) // change based on how many labels
        lineChartView.xAxis.axisLineColor = .darkGreen
        lineChartView.xAxis.axisMaxLabels = 8
        lineChartView.extraRightOffset = 30
        
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
    }
    
    static func lineChartSetPreset(_ set: LineChartDataSet) {
        
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.valueFont = UIFont(name: "Verdana", size: 10)!
        set.setCircleColor(UIColor.seaGreen)
        set.circleHoleColor = .white
        set.valueTextColor = UIColor.seaGreen
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.seaGreen)
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
