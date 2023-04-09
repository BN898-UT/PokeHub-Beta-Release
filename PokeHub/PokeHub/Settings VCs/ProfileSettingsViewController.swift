// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  ProfileSettingsViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import FirebaseAuth

// Code for profile settings
class ProfileSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "ProfileSettings.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        
        confirmPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.isSecureTextEntry = true
        passwordTextField.isSecureTextEntry = true
        profilePic.image = UIImage(named: "stockPfp")
        // sets status background color
        makeStatusBar(view: self.view)
    }
    
    // functionality for confirmation button
    @IBAction func confirmPressed(_ sender: Any) {
//        reauthenticate
        let user = Auth.auth().currentUser
        let newPass = newPasswordTextField.text
        let confPass = confirmPasswordTextField.text
        var credential: AuthCredential
        credential = EmailAuthProvider.credential(withEmail: "\(usernameTextField.text!)", password: "\(passwordTextField.text!)")

        // Prompt the user to re-provide their sign-in credentials
        user?.reauthenticate(with: credential) { result, error  in
          if let error = error {
            // An error happened.
              print(error)
              print("reauth error!@!!!")
          } else {
            // User re-authenticated.
              if(newPass == confPass) {
                  Auth.auth().currentUser?.updatePassword(to: self.newPasswordTextField.text!) { error in
                      if let error = error {
                          // An error happened.
                          print(error)
                      }
                      print("success!!!!")
                      let updatedSuccess = UIAlertController(
                          title: "Password Successfully Changed",
                          message: "",
                          preferredStyle: .alert)
                      
                      updatedSuccess.addAction(UIAlertAction(title: "Close", style: .default))
                      
                      self.present(updatedSuccess, animated: true)                  }
              } else {
                  let passAlert = UIAlertController(
                      title: "Passwords do not match",
                      message: "check your passwords and try again",
                      preferredStyle: .alert)
                  
                  passAlert.addAction(UIAlertAction(title: "Close", style: .default))
                  
                  self.present(passAlert, animated: true)
              }
          }
        }
    }
    
    //functionality for change picture button
    @IBAction func changePic(_ sender: Any) {
         //Create the AlertController and add Its action like button in Actionsheet
         let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
         actionSheetController.view.tintColor = UIColor.black
         let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
             print("Cancel")
         }
         actionSheetController.addAction(cancelActionButton)

         let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
         { action -> Void in
             self.camera()
         }
         actionSheetController.addAction(saveActionButton)

         let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
         { action -> Void in
             self.gallery()
         }
         actionSheetController.addAction(deleteActionButton)
         self.present(actionSheetController, animated: true, completion: nil)
     }

    //functionality to get picture from camera
     func camera()
     {
         let myPickerControllerCamera = UIImagePickerController()
         myPickerControllerCamera.delegate = self
         if UIImagePickerController.isSourceTypeAvailable(.camera){
             myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
             myPickerControllerCamera.allowsEditing = true
             self.present(myPickerControllerCamera, animated: true, completion: nil)
         } else {
             let cameraAlert = UIAlertController(
                 title: "No Camera Available",
                 message: "No camera to take photo",
                 preferredStyle: .alert)
             cameraAlert.addAction(UIAlertAction(title: "Close", style: .default))
             self.present(cameraAlert, animated: true)
         }
     }

    //functionaliy to get picture from galler
     func gallery()
     {
         let myPickerControllerGallery = UIImagePickerController()
         myPickerControllerGallery.delegate = self
         myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
         myPickerControllerGallery.allowsEditing = true
         self.present(myPickerControllerGallery, animated: true, completion: nil)

     }

    // functionality to choose photo from gallery or camera
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         // The info dictionary may contain multiple representations of the image. You want to use the original.
         guard let selectedImage = info[.originalImage] as? UIImage else {
             fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
         }
         // Set photoImageView to display the selected image.
         profilePic.image = selectedImage
         // Dismiss the picker.
         dismiss(animated: true, completion: nil)
     }
    
    // functionality for delete button
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let user = Auth.auth().currentUser
        let confirmDelete = UIAlertController(
            title: "Are you sure you want to delete your account?",
            message: "All data will be lost",
            preferredStyle: .alert)
        
        confirmDelete.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(action) in
            user?.delete()
            print("USER DELETED")
            self.dismiss(animated: true)
            }))
        
        confirmDelete.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(confirmDelete, animated: true)
    }
}
