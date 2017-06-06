//
//  ViewController.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/4/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet var userTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var forgotPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



    
    //Button Actions
    @IBAction func logIn(_ sender: UIButton) {
        
        if checkData(){
            self.startAnimating(message: "Iniciando Sesión", type: NVActivityIndicatorType.ballClipRotate)
            
            DataService.sharedInstance.login(self.userTextField.text!, self.passwordTextField.text!) { (error, user) in
                
                
                
                if let e = error{
                    self.stopAnimating()
                    self.displayMessage("Rutappy", message: e.localizedDescription)
                }else{
                    self.stopAnimating()
                    print("Logged in")
                    self.stopAnimating()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Load Data VC") as! LoadDataController
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Map Controller") as! MapController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }

    @IBAction func register(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Register VC") as! RegisterController
        
        self.present( vc, animated: true, completion: nil)
        
    }
    
    //Supporting functions
    
    func checkData() -> Bool{
        if (self.userTextField.text?.isEmpty)! || (self.passwordTextField.text?.isEmpty)!{
            
            self.displayMessage("Rutappy", message: "Usuario y contraseña requeridos para inciar sesión")
            
            return false
        }
        return true
    }
    
}

extension UIViewController{
    func displayMessage(_ title: String?,message :String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultaction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultaction)
        present(alert, animated: true, completion: nil)
    }
}

