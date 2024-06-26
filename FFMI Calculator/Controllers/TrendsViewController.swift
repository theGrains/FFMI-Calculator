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
    var selectedDP: UserData = UserData()
    var selectedDPInd: Int = 0
    var dataToPlot: String = "FFMI"
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var ffmiPlotButton: UIButton!
    @IBOutlet weak var affmiPlotButton: UIButton!
    @IBOutlet weak var fatPlotButton: UIButton!
    @IBOutlet weak var weightPlotButton: UIButton!
    
    @IBOutlet weak var trendsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        lineChartView.delegate = self
        axisFormatDelegate = self
        lineChartView.xAxis.valueFormatter = axisFormatDelegate
        
        customMarkerView.chartView = lineChartView
        lineChartView.marker = customMarkerView
        
        userData = realm.objects(UserData.self)
        
        ChartPresets.lineChartPreset(userData!, lineChartView, dataToPlot)
        CreateChart.setData(userData!, lineChartView, dataToPlot)
        
//        let VCButtonArray: [UIButton] = [measureButton, methodologyButton, settingsButton]
//        K.ChangeBorder.borderVCButtons(VCButtonArray)
        
        let plotButtonArray: [UIButton] = [ffmiPlotButton, affmiPlotButton, fatPlotButton, weightPlotButton]
        K.ChangeBorder.borderVCButtons(plotButtonArray)
        
        if userData!.count == 1 {
            deleteButton.alpha = 1
        }
        //        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
//    @IBAction func changeVCButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "trendsTo\(sender.currentTitle!)", sender: self)
//    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        if deleteButton.alpha == 1 {
            deleteButton.alpha = 0.5
            lineChartView.highlightValue(nil, callDelegate: false)
            lineChartView.moveViewToX(0.0)
            if userData!.count > 1 {
                do {
                    try realm.write {
                        realm.delete(selectedDP)
                    }
                } catch {
                    print("There was an error trying to delete")
                }
            } else if userData!.count == 1 {
                deleteButton.alpha = 1
                do {
                    try realm.write {
                        realm.delete(userData![0])
                    }
                } catch {
                    print("There was an error trying to delete")
                }
            }
        }
        lineChartView.highlightValue(nil, callDelegate: false)
        chartValueNothingSelected(lineChartView)
        ChartPresets.lineChartPreset(userData!, lineChartView, dataToPlot)
        CreateChart.setData(userData!, lineChartView, dataToPlot)
    }
    
    @IBAction func dataButtonPressed(_ sender: UIButton) {
        
        dataToPlot = sender.currentTitle!
        trendsLabel.text = "\(dataToPlot) Trends"
        lineChartView.highlightValue(nil, callDelegate: false)
        chartValueNothingSelected(lineChartView)
        ChartPresets.lineChartPreset(userData!, lineChartView, dataToPlot)
        CreateChart.setData(userData!, lineChartView, dataToPlot)
        sender.backgroundColor = UIColor.darkGreen
        let plotButtonArray: [UIButton] = [ffmiPlotButton, affmiPlotButton, fatPlotButton, weightPlotButton]
        for button in plotButtonArray {
            if sender.currentTitle != button.currentTitle {
                button.backgroundColor = UIColor.seaGreen
            }
        }
    }
}


extension TrendsViewController: ChartViewDelegate, AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: userData![Int(value)].date))
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        // need to refactor of all this
        let contentView = customMarkerView.getMarker()
        let yPoint = highlight.yPx
        
        deleteButton.alpha = 1
        selectedDP = userData![Int(entry.x)]
        selectedDPInd = Int(entry.x)
        
        var weightUnit: String
        var circumUnit: String
        
        if selectedDP.unitImperial == true {
            weightUnit = "lbs"
            circumUnit = "inch"
            customMarkerView.weightLabel.text = "Weight = \(String(format: "%.1f", userData![Int(entry.x)].weight)) \(weightUnit)"
        } else {
            weightUnit = "kg"
            circumUnit = "cm"
            customMarkerView.weightLabel.text = "Mass = \(String(format: "%.2f", userData![Int(entry.x)].weight)) \(weightUnit)"
        }
        
        
        dateFormatter.dateFormat = "MM/dd" // change possibly depending on imperial or metric
        customMarkerView.dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(userData![Int(entry.x)].date)))
        customMarkerView.currentDataLabel.text = "FFMI = \(String(format: "%.2f", userData![Int(entry.x)].FFMI))"
        customMarkerView.affmiLabel.text = "AFFMI = \(String(format: "%.2f", userData![Int(entry.x)].AFFMI))"
        customMarkerView.fatLabel.text = "Fat % = \(String(format: "%.2f", userData![Int(entry.x)].fat))%"
        
        var markerHeight = 0
        if userData![Int(entry.x)].neck == 0.0 {
            markerHeight = 90
            customMarkerView.neckLabe.text = ""
            customMarkerView.waistLabel.text = ""
            customMarkerView.hipLabel.text = ""
        } else if userData![Int(entry.x)].hip == 0.0 {
            markerHeight = 122
            customMarkerView.neckLabe.text = "Neck = \(String(userData![Int(entry.x)].neck)) \(circumUnit)"
            customMarkerView.waistLabel.text = "Waist = \(String(userData![Int(entry.x)].waist)) \(circumUnit)"
            customMarkerView.hipLabel.text = ""
        } else {
            markerHeight = 138
            customMarkerView.neckLabe.text = "Neck = \(String(userData![Int(entry.x)].neck)) \(circumUnit)"
            customMarkerView.waistLabel.text = "Waist = \(String(userData![Int(entry.x)].waist)) \(circumUnit)"
            customMarkerView.hipLabel.text = "Hip = \(String(userData![Int(entry.x)].hip)) \(circumUnit)"
        }
        
        if Int(entry.x) == 0 {
            contentView.frame = (CGRect(x: 0, y: Int(-yPoint), width: 93, height: markerHeight))
        } else if Int(entry.x) == userData!.count-1 {
            contentView.frame = (CGRect(x: -93, y: Int(-yPoint), width: 93, height: markerHeight))
        } else {
            contentView.frame = (CGRect(x: -46, y: Int(-yPoint), width: 93, height: markerHeight))
        }
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
        if userData!.count != 1 {
            deleteButton.alpha = 0.5
        } else {
            deleteButton.alpha = 1
        }
    }
}
