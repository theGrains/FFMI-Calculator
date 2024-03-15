//
//  CustomMarkerView.swift
//  FFMI Calculator
//
//  Created by Trenton Hegranes on 2/20/24.
//

import UIKit
import DGCharts

class CustomMarkerView: MarkerView {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentDataLabel: UILabel!
    @IBOutlet weak var affmiLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var neckLabe: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var hipLabel: UILabel!
    
    @IBOutlet var chartMarkerView: MarkerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        addSubview(contentView)
        
    }
    
    func changeFrame(_ frame: CGRect) {
        contentView.frame = frame
    }
    
    func getMarker() -> UIView {
        return contentView
    }
    
}
