//
//  ChartRealTime.swift
//  Dreamer
//
//  Created by Genuine on 1/31/19.
//  Copyright © 2019 Genuine. All rights reserved.
//

import Foundation

@IBOutlet weak var chartView: LineChartView!
var xAxisArray : [String]?
var yAxisArray : [Double]?
var date : NSDate?
var dateFormatter : NSDateFormatter?

override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Live Graph"
    
    let stringArray = NSMutableArray()
    let numberArray = NSMutableArray()
    
    dateFormatter = NSDateFormatter()
    dateFormatter!.dateFormat = "HH:mm:ss"
    date = NSDate()
    
    //Insert random values into chart
    for(var i = 0; i < 40; i++)
    {
        date = date!.dateByAddingTimeInterval(0.3)
        let stringDate = dateFormatter?.stringFromDate(date!)
        stringArray.addObject(stringDate!)
        let randomNum = self.randomBetweenNumbers(0.0005, secondNum: 0.0015)
        numberArray.addObject(randomNum)
    }
    
    xAxisArray = stringArray as NSArray as? [String]
    yAxisArray = numberArray as NSArray as? [Double]
    
    configureChart()
    setData()
    
    NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "updateChart", userInfo: nil, repeats: true)
}

func configureChart()
{
    //Chart config
    chartView.descriptionText = ""
    chartView.noDataTextDescription = "Add Data"
    chartView.drawGridBackgroundEnabled = false
    chartView.dragEnabled = true
    chartView.rightAxis.enabled = false
    chartView.doubleTapToZoomEnabled = false
    chartView.legend.enabled = false
    
    //Configure xAxis
    let chartXAxis = chartView.xAxis as ChartXAxis
    chartXAxis.labelPosition = .Bottom
    chartXAxis.setLabelsToSkip(5)
    
    //configure yAxis
    
    chartView.zoom(1.0, scaleY: 1.0, x: 0.0, y: 0.0)
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func updateChart()
{
    let mutableArray = NSMutableArray()
    for(var i = 1; i < xAxisArray?.count; i++)
    {
        mutableArray.addObject(xAxisArray![i])
    }
    
    date = date!.dateByAddingTimeInterval(1.0)
    let str = dateFormatter!.stringFromDate(date!)
    mutableArray.addObject(str)
    
    xAxisArray = mutableArray as NSArray as? [String]
    
    //Numbers
    let numberArray = NSMutableArray()
    for(var i = 1; i < yAxisArray?.count; i++)
    {
        numberArray.addObject(yAxisArray![i])
    }
    
    
    let randomNum = self.randomBetweenNumbers(0.0005, secondNum: 0.0015)
    let convertToDouble = Double(randomNum)
    
    numberArray.addObject(convertToDouble)
    
    yAxisArray = numberArray as NSArray as? [Double]
    
    setData()
    
}

func setData()
{
    // 1 - creating an array of data entries
    var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
    for var i = 0; i < xAxisArray!.count; i++ {
        yVals1.append(ChartDataEntry(value: yAxisArray![i], xIndex: i))
    }
    
    // 2 - create a data set with our array
    let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: "")
    
    set1.axisDependency = .Left // Line will correlate with left axis values
    set1.setColor(UIColor.blueColor().colorWithAlphaComponent(0.5)) // our line's opacity is 50%
    set1.setCircleColor(UIColor.blueColor()) // our circle will be dark red
    set1.lineWidth = 2.0
    set1.circleRadius = 6.0 // the radius of the node circle
    set1.fillAlpha = 65 / 255.0
    set1.fillColor = UIColor.blueColor()
    set1.highlightColor = UIColor.whiteColor()
    set1.drawCircleHoleEnabled = true
    set1.drawFilledEnabled = true
    
    //3 - create an array to store our LineChartDataSets
    var dataSets : [LineChartDataSet] = [LineChartDataSet]()
    dataSets.append(set1)
    
    //4 - pass our months in for our x-axis label value along with our dataSets
    let data: LineChartData = LineChartData(xVals: xAxisArray, dataSets: dataSets)
    
    //5 - finally set our data
    self.chartView.data = data
    
    //Clear text color
    chartView.data?.setValueTextColor(UIColor.clearColor())
}
