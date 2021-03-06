//
//  ChartViewCell.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 25/02/21.
//

import UIKit
import Charts

class ChartViewCell: UICollectionViewCell {
        
    // MARK: - Properties
    
    lazy var yvalues: [ChartDataEntry] = [
        ChartDataEntry(x: 15.0, y: 38.0),
        ChartDataEntry(x: 17.0, y: 35.0),
        ChartDataEntry(x: 22.5, y: 30.0),
        ChartDataEntry(x: 25.0, y: 31.0),
        ChartDataEntry(x: 30.0, y: 33.0),
        ChartDataEntry(x: 35.0, y: 25.0),
        ChartDataEntry(x: 37.5, y: 17.0),
        ChartDataEntry(x: 40.0, y: 18.0),
        ChartDataEntry(x: 45.0, y: 19.0),
        ChartDataEntry(x: 49.0, y: 23.0),
        ChartDataEntry(x: 52.5, y: 35.0),
        ChartDataEntry(x: 55.0, y: 30.0),
        ChartDataEntry(x: 60.0, y: 20.0),

    ]
    
    lazy var lineCharView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.setLabelCount(4, force: true)
        chartView.xAxis.valueFormatter = YAxisValueFormatter()
        
        chartView.leftAxis.setLabelCount(3, force: true)
        chartView.leftAxis.drawAxisLineEnabled = false
                
        chartView.isUserInteractionEnabled = false
        chartView.legend.enabled = false
        
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(lineCharView)
        setData()
//        lineCharView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,paddingLeft: 12, paddingRight: 12, height: 150)
        
        lineCharView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    class YAxisValueFormatter: IAxisValueFormatter {
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            let newValue = String(format: "%.0f", value)
            return String(newValue) + " min"
        }
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yvalues)
        
        set1.lineWidth = 3
        guard let purpleNS = NSUIColor(named: "secondarypurple") else { return }
        set1.setColor(purpleNS)
        set1.setCircleColor(purpleNS)
        set1.circleHoleColor = purpleNS
        set1.mode = .cubicBezier
//        set1.drawCirclesEnabled = false
                
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        lineCharView.data = data
        
    }
}
