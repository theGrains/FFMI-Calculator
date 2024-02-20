//
//  TrendsViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/3/24.
//

import UIKit
import DGCharts
import TinyConstraints
import RealmSwift

class TrendsViewController: UIViewController, AxisValueFormatter{
    
    let realm = try! Realm()
    var userData: Results<UserData>?
    let dateFormatter = DateFormatter()
    weak var axisFormatDelegate: AxisValueFormatter?
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        axisFormatDelegate = self
        lineChartView.delegate = self
        
        let userData = realm.objects(UserData.self)
        lineChartView.xAxis.setLabelCount(userData.count, force: true) // may need to figure out how to change this
        
        lineChartView.backgroundColor = UIColor.regularGreen
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.leftAxis.labelTextColor = .darkBlue
        lineChartView.leftAxis.axisLineColor = .darkGreen
        lineChartView.leftAxis.labelPosition = .outsideChart
        // could need to change these two depending on the possibility of values
        lineChartView.leftAxis.axisMaximum = 40
        lineChartView.leftAxis.axisMinimum = 12
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12) // change based on how many labels
        lineChartView.xAxis.axisLineColor = .darkGreen
        lineChartView.xAxis.axisMaxLabels = 10 // may need to adjust this later as well
        lineChartView.extraRightOffset = 30
        
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
        lineChartView.xAxis.valueFormatter = axisFormatDelegate
        self.setData(userData)
        
        let actionButtonArray: [UIButton] = [measureButton, methodologyButton, settingsButton]
        
        self.borderButtons(actionButtonArray)
//       print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func borderButtons(_ buttonArray: [UIButton]) {
        for button in buttonArray {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.darkGreen.cgColor
        }
    }
    
    func setData(_ userData: Results<UserData>) {
        
        var FFMIplot: [ChartDataEntry] = []
        var count = 0.0
        for dp in userData {
            let FFMIvalue = dp.FFMI!.index(dp.FFMI!.endIndex, offsetBy: -5)..<dp.FFMI!.endIndex
            FFMIplot.append(ChartDataEntry(x: count, y: Double(dp.FFMI![FFMIvalue])!))
            count += 1
        }
        
        count = 0.0
        
        let set = LineChartDataSet(entries: FFMIplot, label: "FFMI")
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
        
        let plot = LineChartData(dataSet: set)
        lineChartView.data = plot
    }
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        
        let userData = realm.objects(UserData.self)
        dateFormatter.dateFormat = "MM/dd" // need to change depending on metric vs. imperial
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(userData[Int(value)].date)))
    }
    
    
    @IBAction func measureButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "trendsToMeasure", sender: self)
    }
}

extension TrendsViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, _ entry: ChartDataEntry, _ highlight: Highlight) {

    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
}
