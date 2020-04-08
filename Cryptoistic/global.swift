//
//  global.swift
//  Cryptoistic
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import Cocoa
//define global structures here
struct LoginInfo:Codable
{
    var login:String
    var password:String
    init(login:String, password:String) {
        self.login = login
        self.password = password
    }
}
//constants
let AUTH_URL:String = "http://107.173.214.176/api/"
//global functions
    //check if the email address is valid or not
func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
    //show messagebox
func showMessagebox( window:NSWindow,title:String,msg:String)
{
   let alert = NSAlert()
   //setting up the alert content
   alert.messageText = title
   alert.informativeText = msg
    alert.window.maxSize = NSSize(width: 400, height: -1)
   alert.beginSheetModal(for:window, completionHandler: nil)
}
//variables
var  gLoginInfo:LoginInfo = LoginInfo(login:"", password:"")
