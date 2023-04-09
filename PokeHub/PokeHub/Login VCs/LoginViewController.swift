// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  LoginViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import FirebaseAuth


// Class for login view controller
class LoginViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    var errorMessage:String = ""
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        passField.isSecureTextEntry = true
        // Listener code to perform segue
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.userField.text = nil
                self.passField.text = nil
            }
        }
    }
    
    // Button to sign in
    @IBAction func signInPressed(_ sender: Any) {
        // Method for sign in
        Auth.auth().signIn(withEmail: userField.text!, password: passField.text!) {
            authResult, error in
            if let error = error as NSError? {
                let signInError = UIAlertController(
                    title: "Sign in error",
                    message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                
                signInError.addAction(UIAlertAction(title: "Close", style: .default))
                
                self.present(signInError, animated: true)

            } else {
                self.errorMessage = ""
            }
        }
    }
}
