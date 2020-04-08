//
//  LoginController.swift
//  Cryptoistic
//
//  Created by Admin on 14/03/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa

class LoginController: NSViewController {
    
    @IBOutlet weak var btnLogin: NSButton!
    @IBOutlet weak var tfEmail: NSTextField!
    @IBOutlet weak var tfPassword: NSSecureTextField!
    
    
    //my variables here
 
    var vcMain: MainController!
    var vcSignup:SignupController!
   
    //loading indicator
   
    @IBOutlet weak var piLoading: NSProgressIndicator!
    //override functions here
    override func viewDidLoad() {
        super.viewDidLoad()
        //init controls
        vcMain = self.storyboard?.instantiateController(withIdentifier: "MainController") as? MainController
      
        vcSignup = self.storyboard?.instantiateController(withIdentifier:  "SignupController") as! SignupController
        //show loading gif
       
       
     
    }
    //event handlers here
    @IBAction func userEnterKey(_ sender: NSTextField) {
        tfPassword.becomeFirstResponder()
    }
    @IBAction func passwordEnteryKey(_ sender: NSSecureTextField) {
        self.loginClilck(self.btnLogin)
    }
    @IBAction func signupClick(_ sender: NSButton) {
        self.presentAsSheet(vcSignup)
    }
    
   
    @IBAction func loginClilck(_ sender: NSButton) {
        
        
        //show indicator
        piLoading.startAnimation(self)
        //vcBase.showMain()
        let urlString = AUTH_URL + "api_signin"
        guard let url = URL(string:urlString) else {fatalError()}
        var request = URLRequest(url:url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
   
        let login = self.tfEmail.stringValue
        let password = self.tfPassword.stringValue
        gLoginInfo =  LoginInfo(login: login, password: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(gLoginInfo)
       
        
            let dataTask = URLSession.shared.dataTask(with: request){ (data, response,error) in
                guard let httpResponse = response as? HTTPURLResponse,  httpResponse.statusCode == 200, let jsonData = data else {
                    let error_msg = error!.localizedDescription
                    DispatchQueue.main.async{
                       self.piLoading.stopAnimation(self)
                       showMessagebox(window:self.view.window!,title:"Sign In Error", msg: error_msg)
                                           
                    }
                    return
                }
                
                let str = String(decoding:jsonData, as:UTF8.self)
                if(str == "success")
                {
                    DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        
                        //show main window
                        //let wcMain = vcMain! as NSWindowController
                        //self.
                        //close me first
                        let windowController = self.storyboard?.instantiateController(withIdentifier: "mainWindow") as? NSWindowController
                        
                        windowController?.showWindow(nil)
                        windowController?.window?.becomeKey()
                        windowController?.window?.becomeMain()
                        windowController?.window?.becomeFirstResponder()
                     
                        self.view.window?.close()
                        self.view.window?.canBecomeKey
                        //self.presentAsSheet(self.vcMain)
                        
                    }
                    
                }
                if(str == "wrong_password")
                {
                    
                    DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign In Error", msg: "Password is wrong." )
                    }
                   
                    
                }
                if(str == "not_exist")
                {
                    DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign In Error", msg: "User does not exist!")
                    }
                }
                
            }
            dataTask.resume()
        } catch{
            print("json encode error")
        }
     }
    override func viewDidAppear() {
        self.view.window!.styleMask.remove(.titled)
        self.view.window!.styleMask.remove(.resizable)
    }
}
