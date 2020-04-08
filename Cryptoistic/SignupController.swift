//
//  SingupController.swift
//  Cryptoistic
//
//  Created by Admin on 15/03/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Cocoa

class SignupController: NSViewController {
    //my variables here
        //my own variables
    var vcLogin:LoginController!
    var vcBase:ViewController!
        //control variables
    @IBOutlet weak var tfPassword: NSSecureTextField!
    @IBOutlet weak var tfConfirm: NSSecureTextField!
    @IBOutlet weak var tfEmail: NSTextField!
    @IBOutlet weak var piLoading: NSProgressIndicator!
    //my handlers here
    
    @IBAction func signupClck(_ sender: NSButton) {
        
         //vcBase.showMain()
         let urlString = AUTH_URL + "api_signup"
         guard let url = URL(string:urlString) else {fatalError()}
         var request = URLRequest(url:url)
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "POST"
    
        
         let login = self.tfEmail.stringValue
         let password = self.tfPassword.stringValue
        let confirm = self.tfConfirm.stringValue
         //check email and password
         if(!isValidEmail(email: login))
         {
            showMessagebox(window:self.view.window!,title:"Sign Up Error", msg: "Email is invalidate.")
            return
         }
        if(password == "")
        {
           showMessagebox(window:self.view.window!,title:"Sign Up Error", msg: "Please input password.")
            self.tfPassword.becomeFirstResponder()
           return
        }
        if(confirm == "")
        {
           showMessagebox(window:self.view.window!,title:"Sign Up Error", msg: "Please input confirm password.")
            self.tfConfirm.becomeFirstResponder()
           return
        }
        if(password != confirm)
        {
           showMessagebox(window:self.view.window!,title:"Sign Up Error", msg: "Password is incorrect.")
           return
        }
         //show indicator
         piLoading.startAnimation(self)
         gLoginInfo =  LoginInfo(login: login, password: password)
         
         do {
             request.httpBody = try JSONEncoder().encode(gLoginInfo)
        
         
             let dataTask = URLSession.shared.dataTask(with: request){ (data, response,error) in
                 guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                     let error_msg = error!.localizedDescription
                     DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign Up Error", msg: error_msg)
                                            
                     }
                     return
                 }
                 
                 let str = String(decoding:jsonData, as:UTF8.self)
                 if(str == "success")
                 {
                        DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign Up " ,msg: "Successfully created a new account.")
                            
 
                     }
                     
                 }
                 if(str == "already_exist")
                 {
                     
                     DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign Up Error" ,msg: "This account already exists.")
                     }
                    
                     
                 }
                 if(str == "not_exist")
                 {
                     DispatchQueue.main.async{
                        self.piLoading.stopAnimation(self)
                        showMessagebox(window:self.view.window!,title:"Sign Up Error",msg: "User does not exist!")
                     }
                 }
                 
             }
             dataTask.resume()
         } catch{
             print("json encode error")
         }
      
    }
    @IBAction func signinClick(_ sender: Any) {
        
        self.dismiss(self)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

    }
    
}
