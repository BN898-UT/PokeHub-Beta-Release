// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  MainMenuViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import Firebase

let appDelegate = UIApplication.shared.delegate as! AppDelegate

var eventList:[NSDictionary] = []
var userID:String = ""
var isDark:Bool = false

// Class for main menu view controller
class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, reloadTable {

    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var dexButton: UIButton!
    
    let eventCell = "eventCell"
    var progFrontLabel:UILabel!
    var progress:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.delegate = self
        eventTable.dataSource = self
        eventList.removeAll()
        // gets the count of captured pokemon
        var count = 0
        for i in 0...captured.count - 1 {
            if captured[i] == true {
                count = count + 1
            }
        }
        // sets percentage
        let percentage = Double(count / 400)
        
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "mainmenu.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        
        // sets progress bar
        progress = UILabel(frame: CGRect(x: 240, y: 5, width: 100, height: 30))
        progress.textAlignment = .right
        progress.textColor = .white
        progress.shadowColor = .white
        // changes format of progress based on user settings
        if displayPercent == false {
            progress.text = "\(count)/400"
        } else {
            progress.text = String(percentage)
        }
        dexButton.addSubview(progress)
        // creates background of progress bar
        let progBackLabel = UILabel(frame: CGRect(x: 30, y: 50, width: 300, height: 47))
        progBackLabel.backgroundColor = UIColor.white
        progFrontLabel = UILabel(frame: CGRect(x: 0, y: 0, width: percentage * 300, height: 47))
        progFrontLabel.backgroundColor = UIColor.cyan
        progBackLabel.layer.masksToBounds = true
        progFrontLabel.layer.masksToBounds = true
        progBackLabel.layer.cornerRadius = 25
        progFrontLabel.layer.cornerRadius = 25
        progBackLabel.addSubview(progFrontLabel)
        self.dexButton.addSubview(progBackLabel)
        
        let user = Auth.auth().currentUser
        if let user = user {
            //while get uid is not recommended to use to store confidential data, we wil use uid as a user's key for this project
            let uid = user.uid
            userID = uid
        }
        
        //retrieve database values for user
        ref = Database.database().reference()
        
        //on load, retrieve calendar data of user
        ref.child("events").child(userID).observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    print("Error")
                    return
                }
                
                let eventDict: NSDictionary = [
                    "title" : dict["title"] as! String,
                    "date" : dict["date"] as! String,
                    "time" : dict["time"] as! String,
                    "desc" : dict["desc"] as! String
                ]
                
                eventList.append(eventDict)
                self.reloadTable()
            }
            //        gets user settings from database
                    ref.child("settings").child(userID).observeSingleEvent(of: .value) { snapshot in
                            guard let dict = snapshot.value as? [String:Any] else {
                                print("Error")
                                return
                            }
                        isDark = dict["darkMode"] as! Bool

            //            sets darkmode based on previous user settings
                            let scenes = UIApplication.shared.connectedScenes
                                   let windowScene = scenes.first as? UIWindowScene
                                   let window = windowScene?.windows.first

                                   if dict["darkMode"] as! Bool {
                                       window?.overrideUserInterfaceStyle = .dark
                                   } else {
                                       window?.overrideUserInterfaceStyle = .light
                                   }
                    }
        }
        // sets status bar background color
        makeStatusBar(view: self.view)
    }
    
    // function to update progress bar and label
    override func viewWillAppear(_ animated: Bool) {
        // gets the count of captured pokemn
        var count = 0
        for i in 0...captured.count - 1 {
            if captured[i] == true {
                count = count + 1
            }
        }
        let percentage = Double(count) / 400.0
        progFrontLabel.frame.size.width = 300 * percentage
        // changes format of progress label
        if displayPercent == false {
            progress.text = "\(count)/400"
        } else {
            progress.text = String(percentage)
        }
    }
    
    // passes variables to event VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEventSegue",
           let nextVC = segue.destination as?
            AddEventViewController {
            nextVC.delegate = self
        }
    }
    
    //show event table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCell, for:indexPath as IndexPath) as! eventViewCell
        cell.textLabel?.numberOfLines = 1
        let row = indexPath.row
        cell.titleLabel.text = eventList[row].value(forKey: "title") as? String
        cell.dateLabel.text = eventList[row].value(forKey: "date") as? String
        return cell
    }
    
    //do swipe to delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //remove data from database
            ref.child("events").child(userID).child("\(indexPath.row)").removeValue()
            
            eventList.remove(at: indexPath.row)
            
            var val = 0
            for item in eventList {
                ref.child("events").child(userID).child("\(val)").setValue(item)
                val = val + 1
            }
            ref.child("events").child(userID).child("\(val)").removeValue()
        
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // returns amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    // reloads the table
    func reloadTable() {
        self.eventTable.reloadData()
    }
}
