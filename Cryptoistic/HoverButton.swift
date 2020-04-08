//
//  HoverButton.swift
//  Cryptoistic
//
//  Created by Admin on 20.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa

class HoverButton: NSButton {
    var normalImage:NSImage?, hoverImage:NSImage?, pressImage:NSImage?, bPressed:Bool=false, bHovered:Bool = false
    var trackingArea:NSTrackingArea!
    func createTrackingArea(){
        if(self.trackingArea != nil)
        {
            self.removeTrackingArea(self.trackingArea)
        }
        let boundRect = self.bounds
        let flag = NSTrackingArea.Options.mouseEnteredAndExited.rawValue + NSTrackingArea.Options.activeInActiveApp.rawValue
        self.trackingArea = NSTrackingArea(rect:boundRect,options: NSTrackingArea.Options(rawValue:flag), owner: self,
        userInfo: nil)
        
        self.addTrackingArea(self.trackingArea)
        
    }
    override init(frame frameRect:NSRect)
    {
        super.init(frame:frameRect)
        self.myinit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.myinit()
    }
    func setImages(imgNor:String, imgHov:String, imgPrs:String)
    {
        self.normalImage = NSImage(named: imgNor)
        self.hoverImage = NSImage(named: imgHov)
        self.pressImage = NSImage(named: imgPrs)
        
        self.image = normalImage
        self.needsDisplay = true
        
        
    }
    func clearBtn()
    {
        self.bHovered = false
        self.bPressed = false
         self.image = normalImage
        self.needsDisplay = true
    }
    func myinit(){
        bPressed = false
        bHovered = false
        self.createTrackingArea()
   
        
    }
    override func mouseEntered(with event: NSEvent) {
        if (self.bPressed){
            return
        }
        self.bHovered = true
        self.image = hoverImage
        self.needsDisplay = true
    }
    override func mouseExited(with event: NSEvent) {
        if (self.bPressed){
            return
        }
        self.bHovered = false
        self.image = normalImage
        self.needsDisplay = true
    }
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        self.bPressed = !self.bPressed
        if(self.bPressed)
        {
            self.image = hoverImage
        }else{
            self.image = normalImage
        }
        self.needsDisplay = true
    }
   
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        

        
    }
    
    
}
