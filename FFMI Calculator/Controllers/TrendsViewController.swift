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
    
    @IBOutlet weak var lineChartView: CombinedChartView!
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var ffmiPlotButton: UIButton!
    @IBOutlet weak var affmiPlotButton: UIButton!
    @IBOutlet weak var fatPlotButton: UIButton!
    @IBOutlet weak var weightPlotButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.delegate = self
        axisFormatDelegate = self
        lineChartView.xAxis.valueFormatter = axisFormatDelegate
        
        customMarkerView.chartView = lineChartView
        lineChartView.marker = customMarkerView
        
        userData = realm.objects(UserData.self)
        
        ChartPresets.lineChartPreset(lineChartView, userData!) // make a parameter here for what is being graphed
        CreateChart.setData(userData!, lineChartView) // make a parameter here for what is being graphed
        
        let VCButtonArray: [UIButton] = [measureButton, methodologyButton, settingsButton]
        K.ChangeBorder.borderVCButtons(VCButtonArray)
        
        let plotButtonArray: [UIButton] = [ffmiPlotButton, affmiPlotButton, fatPlotButton, weightPlotButton]
        K.ChangeBorder.borderVCButtons(plotButtonArray)
        
        if userData!.count == 1 {
            deleteButton.alpha = 1
        }
        //        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    @IBAction func changeVCButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "trendsTo\(sender.currentTitle!)", sender: self)
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        if deleteButton.alpha == 1 {
            deleteButton.alpha = 0.5
            lineChartView.highlightValue(nil)
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
                    print("There was an error trying to delte")
                }
            }
        }
        chartValueNothingSelected(lineChartView)
        ChartPresets.lineChartPreset(lineChartView, userData!)
        CreateChart.setData(userData!, lineChartView)
    }
}


extension TrendsViewController: ChartViewDelegate, AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: userData![Int(value)].date))
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        // need to refactor of all this
        // consider metric/imperial
        
        deleteButton.alpha = 1
        selectedDP = userData![Int(entry.x)]
        selectedDPInd = Int(entry.x)
        
        var weightUnit: String
        var circumUnit: String
//        var dividingFactorWeight: Float
//        var dividingFactorCircum: Float
        
        if selectedDP.unitImperial == true {
            weightUnit = "lbs"
            circumUnit = "inch"
            customMarkerView.weightLabel.text = "Weight = \(String(format: "%.1f", userData![Int(entry.x)].weight)) \(weightUnit)"
        } else {
            weightUnit = "kg"
            circumUnit = "cm"
            customMarkerView.weightLabel.text = "Weight = \(String(format: "%.2f", userData![Int(entry.x)].weight)) \(weightUnit)"
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
        
        let contentView = customMarkerView.getMarker()
        self.view.bringSubviewToFront(contentView)
        
        if Int(entry.x) == 0 {
            customMarkerView.changeFrame(CGRect(x: 0, y: -240, width: 93, height: markerHeight))
        } else if Int(entry.x) == userData!.count-1 {
            customMarkerView.changeFrame(CGRect(x: -93, y: -240, width: 93, height: markerHeight))
        } else {
            customMarkerView.changeFrame(CGRect(x: -46, y: -240, width: 93, height: markerHeight))
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
