//
//  RegisterController.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/4/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegisterController: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet var idTextField: UITextField!
    
    @IBOutlet var nameTextfield: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Button actions
    
    @IBAction func signUp(_ sender: UIButton) {
        if checkData(){
            
            self.startAnimating(message: "Registrando", type: NVActivityIndicatorType.ballClipRotate)
            DataService.sharedInstance.signUp(self.nameTextfield.text!, self.emailTextField.text!, self.passwordTextField.text!, self.idTextField.text!, cb: { (error) in
                if let e = error{
                    self.stopAnimating()
                    self.displayMessage("Rutappy", message: e.localizedDescription)
                }else{
                    self.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func closeWindow(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Supporting functions
    
    func checkData() -> Bool{
        if (self.idTextField.text?.isEmpty)! || (self.nameTextfield.text?.isEmpty)! || (self.emailTextField.text?.isEmpty)! || (self.passwordTextField.text?.isEmpty)!{
            
            self.displayMessage("Rutappy", message: "Todos los campos son requeridos para registrarse")
            
            return false
        }
        
        
        return true
    }
}
