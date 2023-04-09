// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  RegistrationViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import FirebaseAuth

// Class for registering for new account
class RegistrationViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confPassField: UITextField!
    var errorMessage:String = ""
    
    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        passField.isSecureTextEntry = true
        confPassField.isSecureTextEntry = true

        // Listener code to perform segue
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "regSegue", sender: nil)
                self.userField.text = nil
                self.passField.text = nil
            }
        }
        // Do any additional setup after loading the view.
    }
    

    // functionality of registration button
    @IBAction func regPressed(_ sender: Any) {
        // Check for Matching passwords in password and confirm password
        if passField.text! != confPassField.text! {
            errorMessage = "Passwords do not match"
            let alert = UIAlertController(title: "Error",
                                          message: "Password and Confirm Password do not match",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        } else {
            // Code to create new user
            Auth.auth().createUser(withEmail: userField.text!, password: passField.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.errorMessage = "\(error.localizedDescription)"
                } else {
                    self.errorMessage = ""
                }
            }
        }
    }
}
