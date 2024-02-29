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
    let xFormatter = XAxisNameFormatter()
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var methodologyButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.delegate = self
        axisFormatDelegate = self
        lineChartView.xAxis.valueFormatter = axisFormatDelegate
        
        customMarkerView.chartView = lineChartView
        lineChartView.marker = customMarkerView
        
        userData = realm.objects(UserData.self)
        
        ChartPresets.lineChartPreset(lineChartView, userData!, xFormatter)
        
        CreateChart.setData(userData!, lineChartView)
        
        let VCButtonArray: [UIButton] = [measureButton, methodologyButton, settingsButton]
        K.ChangeBorder.borderVCButtons(VCButtonArray)
//       print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    @IBAction func changeVCButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "trendsTo\(sender.currentTitle!)", sender: self)
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        if deleteButton.alpha == 1 {
            lineChartView.highlightValue(nil)
            lineChartView.moveViewToX(0.0)
            do {
                try realm.write {
                    realm.delete(selectedDP)
                }
            } catch {
                print("There was an error trying to delete")
            }
        }
        
        chartValueNothingSelected(lineChartView)
        ChartPresets.lineChartPreset(lineChartView, userData!, xFormatter)
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
        // consider male/female
        // consider metric/imperial
        // lots of things to consider here
        
        deleteButton.alpha = 1
        selectedDP = userData![Int(entry.x)]
        selectedDPInd = Int(entry.x)
        
        dateFormatter.dateFormat = "MM/dd" // change possibly depending on imperial or metric
        customMarkerView.dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(userData![Int(entry.x)].date)))
        customMarkerView.currentDataLabel.text = userData![Int(entry.x)].FFMI
        let AFFMIvalue = userData![Int(entry.x)].AFFMI!.index(userData![Int(entry.x)].AFFMI!.endIndex, offsetBy: -5)..<userData![Int(entry.x)].AFFMI!.endIndex
        customMarkerView.affmiLabel.text = "AFFMI \(userData![Int(entry.x)].AFFMI![AFFMIvalue])"
        customMarkerView.fatLabel.text = userData![Int(entry.x)].fat
        customMarkerView.weightLabel.text = "Weight = \(userData![Int(entry.x)].weight ?? "") lbs"
        customMarkerView.neckLabe.text = userData![Int(entry.x)].neck
        customMarkerView.waistLabel.text = userData![Int(entry.x)].waist
        customMarkerView.hipLabel.text = userData![Int(entry.x)].hip
        
        var markerHeight = 0
        if userData![Int(entry.x)].neck! == "" {
            markerHeight = 90
        } else {
            markerHeight = 138
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
        
        deleteButton.alpha = 0.5
    }
}
