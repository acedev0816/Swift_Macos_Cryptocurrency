//
//  ViewController.swift
//  Cryptoistic
//
//  Created by Admin on 14/03/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa
import Cryptex
import Charts
class ViewController: NSViewController {
    //here are my variables
    
  
    @IBOutlet weak var ivBack: NSImageView!
    
    @IBOutlet weak var container: NSView!
    var vcLogin: LoginController!
    var vcMain: MainController!
    var vcSignup:SignupController!
    var loginInfo:LoginInfo!
    
    var bLoginActive : Bool = false
    func randomFloatBetween(from: Float, to: Float)->Float
    {
        return Float(arc4random_uniform( UInt32(to - from ))) + Float(from)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load sub views
        vcLogin = self.storyboard?.instantiateController(withIdentifier:"LoginController") as! LoginController
        vcMain = self.storyboard?.instantiateController(withIdentifier: "MainController") as! MainController
        
        vcSignup = self.storyboard?.instantiateController(withIdentifier:  "SignupController") as! SignupController
        
        //add refernces to child
        
      
        //add childs
        self.addChild(vcLogin)
        self.addChild(vcMain)
        self.addChild(vcSignup)
        
      
        showLogin()
        //hide
        
       
    }
    override func viewDidAppear() {
        self.view.window!.styleMask.remove(.resizable)
    }
    func testChart()
    {
        let ITEM_COUNT  = 20


        let r = CGRect(x: 0, y: 0, width: 400, height: 400)
        var chartView = CandleStickChartView(frame: r)
        //: ### General
        chartView.drawGridBackgroundEnabled = true
        //: ### xAxis
        let xAxis                           = chartView.xAxis
        xAxis.labelPosition                 = .bothSided
        xAxis.axisMinimum                   = 0.0
        xAxis.granularity                   = 1.0
        //: ### LeftAxis
        let leftAxis                        = chartView.leftAxis
        leftAxis.drawGridLinesEnabled       = true
        leftAxis.axisMinimum                = 40.0
        leftAxis.axisMaximum                = 100.0
        //: ### RightAxis
        let rightAxis                       = chartView.rightAxis
        rightAxis.drawGridLinesEnabled      = true
        rightAxis.axisMinimum               = 40
        rightAxis.axisMaximum = 100
        //: ### Legend
        let legend                          = chartView.legend
        legend.wordWrapEnabled              = true
        legend.horizontalAlignment          = .center
        legend.verticalAlignment            = .bottom
        legend.orientation                  = .horizontal
        legend.drawInside                   = false
        //: ### Description
        chartView.chartDescription?.enabled = true
        //: ### CandleChartDataEntry
        var entries = [CandleChartDataEntry]()

        for i in 0..<ITEM_COUNT
        {
            let mult: Float = 50
            let val = randomFloatBetween(from: mult, to: mult + 40)
            let high = randomFloatBetween(from: 8, to: 17)
            let low: Float = randomFloatBetween(from: 8, to: 17)
            let open: Float = randomFloatBetween(from: 1, to: 7)
            let close: Float = randomFloatBetween(from: 1, to: 7)
            let even: Bool = i % 2 == 0
            
            entries.append(CandleChartDataEntry(x: Double(i), shadowH: Double(val + high), shadowL: Double(val - low), open: Double(even ? val + open : val - open), close: Double(even ? val - close : val + close)))
            }
        //: ### CandleChartDataSet
        let set = CandleChartDataSet(entries: entries, label: "Candle DataSet")
        set.colors = [#colorLiteral(red: 0.313725490196078, green: 0.313725490196078, blue: 0.313725490196078, alpha: 1.0)]

        set.decreasingColor = NSColor.red
        set.increasingColor = NSColor.green
        set.increasingFilled = true
        
        set.shadowColor = NSColor.red
        set.valueFont = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        set.drawValuesEnabled = true
        set.shadowWidth = 0.7
        
        //: ### CandleChartData
        let data = CandleChartData()
        data.addDataSet(set)
        chartView.data = data
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        //add
        
        chartView.frame = self.container.bounds
        self.container?.addSubview(chartView)
        
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func showMain(){
        //resize
        self.container.frame = NSRect(x: 0, y: 0, width: 1024, height: 700)
        //remove first
        for sView in self.container.subviews {
            sView.removeFromSuperview()
        }
        
        //add
        vcMain.view.frame = self.container.bounds
        self.container!.addSubview(vcMain.view)
        
        self.ivBack.image = nil
        
        
    }
    func showSignup(){
        //remove first
        for sView in self.container.subviews {
            sView.removeFromSuperview()
        }
        
        //add
        vcSignup.view.frame = self.container.bounds
        self.container!.addSubview(vcSignup.view)
    }
    func showLogin(){
        //remove first
        for sView in self.container.subviews {
            sView.removeFromSuperview()
        }
        
        //add
        vcLogin.view.frame = self.container.bounds
        self.container!.addSubview(vcLogin.view)
    }
   


}

