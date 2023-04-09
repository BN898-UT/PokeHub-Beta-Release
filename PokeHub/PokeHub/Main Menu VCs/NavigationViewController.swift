// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  NavigationViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

class NavigationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    var segueIdentifier = ""
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // sets navigation and status bar background color
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        makeStatusBar(view: self.view)
    }
    
    // Function to return view table count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navBar.count
    }
    
    // Function to set the text of the view table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = navBar[row]
        return cell
    }
    
    // Function to set segueIdentifier to proper view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            segueIdentifier = "MainMenuSegue"
        case 1:
            segueIdentifier = "MapSegue"
        case 2:
            segueIdentifier = "PokedexSegue"
        case 3:
            segueIdentifier = "NuzlockeSegue"
        case 4:
            segueIdentifier = "BattleTrackerSegue"
        case 5:
            segueIdentifier = "TeamBuilderSegue"
        case 6:
            segueIdentifier = "SettingSegue"
        default:
            break
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
