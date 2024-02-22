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
    
    @IBAction func moreInfoButtonPressed(_ sender: UIButton) {
        print("hello")
    }
    
}
