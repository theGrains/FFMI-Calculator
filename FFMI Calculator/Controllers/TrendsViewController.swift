//
//  TrendsViewController.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/3/24.
//

import UIKit
import DGCharts
import RealmSwift

class TrendsViewController: UIViewController {
    
    let realm = try! Realm()
    var userData: Results<UserData>?
    let dateFormatter = DateFormatter()
    weak var axisFormatDelegate: AxisValueFormatter?
    let customMarkerView = CustomMarkerView()
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.delegate = self
        axisFormatDelegate = self
        lineChartView.xAxis.valueFormatter = axisFormatDelegate
        customMarkerView.chartView = lineChartView
        lineChartView.marker = customMarkerView
        
        let userData = realm.objects(UserData.self)
        
        ChartPresets.lineChartPreset(lineChartView)
        
        CreateChart.setData(userData, lineChartView)
        
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
    
    @IBAction func measureButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "trendsToMeasure", sender: self)
    }
}

extension TrendsViewController: ChartViewDelegate, AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        
        let userData = realm.objects(UserData.self)
        dateFormatter.dateFormat = "MM/dd" // need to change depending on metric vs. imperial
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(userData[Int(value)].date)))
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let userData = realm.objects(UserData.self)
        dateFormatter.dateFormat = "MM/dd"
        customMarkerView.currentDataLabel.text = userData[Int(entry.x)].FFMI
        customMarkerView.dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(userData[Int(entry.x)].date)))
        
        let contentView = customMarkerView.getMarker()
        self.view.bringSubviewToFront(contentView)
        
        if Int(entry.x) == 0 {
            customMarkerView.changeFrame(CGRect(x: 0, y: -240, width: 93, height: 138))
        } else if Int(entry.x) == userData.count-1 {
            customMarkerView.changeFrame(CGRect(x: -93, y: -240, width: 93, height: 138))
        } else {
            customMarkerView.changeFrame(CGRect(x: -46, y: -240, width: 93, height: 138))
        }
        
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
}
