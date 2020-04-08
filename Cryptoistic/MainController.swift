//
//  MainController.swift
//  Cryptoistic
//
//  Created by Admin on 14/03/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa

class MainController: NSViewController,NSTableViewDataSource,NSTableViewDelegate
{
    

    //uis for left bar
    @IBOutlet weak var btnSg: HoverButton!
    @IBOutlet weak var btnMd: HoverButton!
    @IBOutlet weak var btnBt: HoverButton!
    @IBOutlet weak var btnStg: HoverButton!
    @IBOutlet weak var btnSt: HoverButton!
    @IBOutlet weak var tabMain: NSTabView!
    //uis for right top
    
    @IBOutlet weak var tfTitle: NSTextField!
    //conrols for Mnaging Data
    
    @IBOutlet weak var btnBinance: HoverButton!
    @IBOutlet weak var btnKraken: HoverButton!
    @IBOutlet weak var btnHuobi: HoverButton!
    @IBOutlet weak var btnBU: NSButton!
    @IBOutlet weak var btnEB: NSButton!
    @IBOutlet weak var btnEU: NSButton!
    var btnLeftCur: HoverButton? = nil
    var btnCECur: HoverButton?=nil
    var btnCTCur:NSButton?=nil
    //controls for signals
    
    @IBOutlet weak var tvSignal: NSTableView!
    
    //model data
    var signalData:NSMutableArray!
    //handlers for Manging Data
    @IBAction func clcikEU(_ sender: NSButton) {
        updateChooseTP(button: sender)
        
    }
    @IBAction func clickEB(_ sender: NSButton) {
        updateChooseTP(button: sender)
        
    }
    @IBAction func clickBU(_ sender: NSButton) {
        updateChooseTP(button: sender)
    }
    @IBAction func clickHuobi(_ sender: HoverButton) {
        updateChooseExcahnge(button: sender)
    }
    
    @IBAction func clickBinance(_ sender: HoverButton) {
        updateChooseExcahnge(button: sender)
    }
    @IBAction func clickKraken(_ sender: HoverButton) {
        updateChooseExcahnge(button: sender)
    }
    //click marketing data
    @IBAction func clickMd(_ sender: HoverButton) {
        updateLeftUi(button: sender)
        //switch tab first
        tabMain.selectTabViewItem(at: 0)
        tfTitle.stringValue = "MARKETING DATA"
        
    }
    //click signal
    @IBAction func clickSg(_ sender: HoverButton) {
        updateLeftUi(button: sender)
        
        //switch tab first
        tabMain.selectTabViewItem(at: 1)
        tfTitle.stringValue = "SIGNALS"
    }
    //click settings
    @IBAction func clickSt(_ sender: HoverButton) {
        updateLeftUi(button: sender)
        
        //switch tab first
        tabMain.selectTabViewItem(at: 2)
        tfTitle.stringValue = "SETTINGS"
    }
    
    //click trading strategy
    @IBAction func clickStg(_ sender: HoverButton) {
        updateLeftUi(button: sender)
        
        //switch tab first
        tabMain.selectTabViewItem(at: 3)
        tfTitle.stringValue = "TRADING STRATEGY"
    }
    //click botsetting
    @IBAction func clickBt(_ sender: HoverButton) {
        updateLeftUi(button: sender)
        
        //switch tab first
        tabMain.selectTabViewItem(at: 4)
        tfTitle.stringValue = "BOT SETTING"
    }
    //initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        //table
        //signals
        tvSignal.headerView = nil
        tvSignal.delegate = self
        tvSignal.dataSource = self
        
        signalData = [
            ["action":"Sell","market":"huobi","price":"250$","timestamp":"4"],
            ["action":"Sell","market":"huobi","price":"250$","timestamp":"4"],
            ["action":"Sell","market":"huobi","price":"250$","timestamp":"4"],
        ]
        // Do view setup here.
        
        //left bar
        btnMd.setImages(imgNor: "btn_md", imgHov: "btn_md_over", imgPrs: "btn_md_over")
        
        btnSg.setImages(imgNor: "btn_sg", imgHov: "btn_sg_over", imgPrs: "btn_sg_over")
        
        btnSt.setImages(imgNor: "btn_st", imgHov: "btn_st_over", imgPrs: "btn_st_over")
        
        btnStg.setImages(imgNor: "btn_stg", imgHov: "btn_stg_over", imgPrs: "btn_sgt_over")
        
        btnBt.setImages(imgNor: "btn_bt", imgHov: "btn_bt_over", imgPrs: "btn_bt_over")
       //manging data
        btnBinance.setImages(imgNor: "btn_binance", imgHov: "btn_binance_over", imgPrs: "btn_binance_over")
        
        btnHuobi.setImages(imgNor: "btn_huobi", imgHov: "btn_huobi_over", imgPrs: "btn_huobi_over")
        
        btnKraken.setImages(imgNor: "btn_kraken", imgHov: "btn_kraken_over", imgPrs: "btn_kraken_over")
        
        
        
        
        
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        tvSignal.reloadData()
    }
    func updateLeftUi(button:HoverButton)
    {
        if btnLeftCur != nil{
            btnLeftCur?.clearBtn()   //clear previous selected button : acer
            
        }
        btnLeftCur = button
    }
    func updateChooseTP(button:NSButton)
    {
        if btnCTCur != nil{
            btnCTCur?.state = .off   //clear previous selected button : acer
            
        }
        btnCTCur = button
    }
    func updateChooseExcahnge(button:HoverButton)
    {
        if btnCECur != nil{
            btnCECur?.clearBtn()   //clear previous selected button : acer
            
        }
        btnCECur = button
    }
    //functions for table show
    func numberOfRows(in tableView:NSTableView)->Int {
        return 5
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = tableColumn!.identifier
        
        tableView.rowHeight = CGFloat(30)
        tableView.intercellSpacing = NSSize(width: 0, height: 0)
        
       // tableView.backgroundColor = NSColor.white
        guard let cellView = tableView.makeView(withIdentifier: id, owner: self)
        as? NSTableCellView else { return nil }
        
        switch id.rawValue  {
        case "action":
            cellView.textField?.stringValue = "Buy Coin"
            
            cellView.textField?.textColor = NSColor.blue
            cellView.textField?.alignment = NSTextAlignment.center
            break
        case "market":
           cellView.textField?.stringValue = "BINANCE BTC/USDT"
           cellView.textField?.alignment = NSTextAlignment.center
           break
        case "price":
           cellView.textField?.stringValue = "$5,850"
           cellView.textField?.alignment = NSTextAlignment.left
           break
        case "timestamp":
            cellView.textField?.stringValue = "02/15/2020 05:30"
            cellView.textField?.alignment = NSTextAlignment.left
            
            break
       
        default:
            break
        }
        
        //cellView.textField?. backgroundColor = NSColor.green
        //background color
        if(row % 2 == 0)
        {
         // cellView.wantsLayer = true
         // cellView.layer?.backgroundColor = NSColor.gray.cgColor
        }
        return cellView
         
       
    }
}
