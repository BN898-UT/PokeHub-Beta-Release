// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  AddEventViewController.swift
//  PokeHub
//
//  Created by Brandon Nguyen on 3/26/23.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    
    var delegate: UIViewController!
    
    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "newevent.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        // changes status background color
        makeStatusBar(view: self.view)
    }
    
    // functionality of done buton
    @IBAction func doneButtonPressed(_ sender: Any) {
//        save information
//        display information in main menu table VC
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"

        if let _ = dateFormatter.date(from: date.text!) {
            
            let eventDict: NSDictionary = [
                "title" : titleInput.text!,
                "date" : date.text!,
                "time" : time.text!,
                "desc" : descriptionInput.text!
            ]
            
            eventList.append(eventDict)
            
            var val = 0
            for item in eventList {
                ref.child("events").child(userID).child("\(val)").setValue(item)
                val = val + 1
            }
            
            let otherVC = delegate as! reloadTable
            otherVC.reloadTable()
            
            navigationController!.popViewController(animated: true)
        }
        else {
            print("Invalid date")
            let dateAlert = UIAlertController(
                title: "Invalid Date Format",
                message: "Please enter a valid date format",
                preferredStyle: .alert)
            
            dateAlert.addAction(UIAlertAction(title: "Close", style: .default))
            
            present(dateAlert, animated: true)
        }
    }
}
