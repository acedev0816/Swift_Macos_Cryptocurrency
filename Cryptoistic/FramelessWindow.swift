//
//  FramelessWindow.swift
//  Cryptoistic
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa
//frameless window
class FramelessWindow: NSWindow {
    override var canBecomeKey: Bool{
        return true
    }
}
//dragable view
class DragImageView: NSImageView {

    override var mouseDownCanMoveWindow:Bool {
        return true
    }
    
}

//dragable view
class DragView: NSView {

    override public func mouseDown(with event: NSEvent) {
        window?.performDrag(with: event)
    }

}
class DragColorWell: NSColorWell {

     override var mouseDownCanMoveWindow:Bool {
           return true
       }

}
