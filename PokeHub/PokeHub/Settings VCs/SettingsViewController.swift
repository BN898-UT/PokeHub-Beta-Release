// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  SettingsViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import FirebaseAuth
import Firebase

// Code for the settings menu
class SettingsViewController: UIViewController {

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var enableSoundSwitch: UISwitch!

    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed

        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "Settings.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        makeStatusBar(view: self.view)
        
        //        saves settings if user has not already
                ref = Database.database().reference()
                ref.child("settings").child(userID).observeSingleEvent(of: .value) { snapshot in
                    guard let dict = snapshot.value as? [String:Any] else {
                        print("Error")
                        self.saveSettings()
                        return
                    }
                    isDark = dict["darkMode"] as! Bool
                }
             
                // keeps darkmode switch accurate
                if isDark {
                    self.darkModeSwitch.setOn(true, animated: false)
                } else {
                    self.darkModeSwitch.setOn(false, animated: false)
                }
    }
    
    // makes switch persist through loads
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad();
    }
    
//    saves settings to database
    func saveSettings() {
        let settingsDict: NSDictionary = [
            "darkMode" : darkModeSwitch.isOn,
            "sound" : enableSoundSwitch.isOn
        ]
        ref.child("settings").child(userID).setValue(settingsDict)
    }
    
    //    enables dark mode using switch change
    @IBAction func switchDidChange(_ sender: UISwitch) {
        let scenes = UIApplication.shared.connectedScenes
               let windowScene = scenes.first as? UIWindowScene
               let window = windowScene?.windows.first
               let interfaceStyle = window?.overrideUserInterfaceStyle == .unspecified ? UIScreen.main.traitCollection.userInterfaceStyle : window?.overrideUserInterfaceStyle
                
//            sets all VCs to dark mode if it isnt already in dark mode
               if interfaceStyle != .dark && sender.isOn{
                   window?.overrideUserInterfaceStyle = .dark
                   isDark = true
                   ref.child("settings").child(userID).child("darkMode").setValue(true)
               } else {
//                  sets all VCs to light mode
                   window?.overrideUserInterfaceStyle = .light
                   ref.child("settings").child(userID).child("darkMode").setValue(false)
                   isDark = false
               }
    }
    
    // Method to log out and go back to sign in page
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "outSegue", sender: nil)
        } catch {
            print("Sign out error")
        }    }
}
