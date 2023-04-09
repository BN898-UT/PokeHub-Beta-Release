// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  NuzlockeViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// Method to implement nuzlocke tracker
class NuzlockeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var deadImg = UIImage(named: "dead")
    var noDeadImg = UIImage(named: "notdead")
    
    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // set status bar background color
        makeStatusBar(view: self.view)
    }
    
    // sets amount of rows for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nuzLocations.count
    }
    
    // fills information in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NuzlockeCell", for: indexPath as IndexPath) as! NuzlockeTableViewCell
        let row = indexPath.row
        //loads previous pokemon
        if nuzPokemon[row] != "" {
            cell.pokemonLabel.text = nuzPokemon[row]
        }
        //loads previous nicknames of pokemon
        if nicknames[row] != ""{
            cell.nicknameLabel.text = nicknames[row]
        }
        cell.nicknameLabel.delegate = self
        cell.nicknameLabel.tag = indexPath.row
        cell.index = indexPath.row
        cell.locationLabel.text = nuzLocations[row]
        cell.deathButton.tag = row
        cell.caughtButton.tag = row
        // loads previous death status of pokemon
        if nuzDead[row] == false {
            cell.deathButton.setImage(noDeadImg, for: .normal)
        } else {
            cell.deathButton.setImage(deadImg, for: .normal)
        }
        // adds functionality to death button
        cell.deathButton.addTarget(self, action: #selector(deathButtonAction), for: .touchUpInside)
        // loads previous caught status of pokmon
        if nuzCaught[row] == false {
            cell.caughtButton.setImage(noCapImg, for: .normal)
        } else {
            cell.caughtButton.setImage(capImg, for: .normal)
        }
        //adds functionality to death button
        cell.caughtButton.addTarget(self, action: #selector(caughtButtonAction), for: .touchUpInside)
        return cell
    }
    
    // function to save text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        // goes through the cells and saves any cell that has text in nicknames
        for i in 0...16{
            if textField.tag == i{
                nicknames[i] = textField.text!
            }
        }
    }
    
    // function to change caught image
    @objc func caughtButtonAction(sender: UIButton!) {
        // switches between caught and not caught image
        nuzCaught[sender.tag] = !nuzCaught[sender.tag]
        if nuzCaught[sender.tag] == false {
            sender.setImage(noCapImg, for: .normal)
        } else {
            sender.setImage(capImg, for: .normal)
        }
    }
    
    // function to change death image
    @objc func deathButtonAction(sender: UIButton!) {
        // switches between dead and not dead image
        nuzDead[sender.tag] = !nuzDead[sender.tag]
        if nuzDead[sender.tag] == false {
            sender.setImage(noDeadImg, for: .normal)
        } else {
            sender.setImage(deadImg, for: .normal)
        }
    }
    
    // function to display which pokemon are still alive
    @IBAction func aliveButton(_ sender: Any) {
        // gets all the pokemon who are alive
        var alive: [String] = []
        for i in 0...nuzPokemon.count - 1{
            if nuzPokemon[i] != "" && nuzDead[i] == false {
                alive.append(nuzPokemon[i])
            }
        }
        // sends alert with information
        let controller = UIAlertController(
            title: "Pokemon Still Alive",
            message: alive.joined(separator: ", "),
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .default))
        present(controller, animated: true)
    }
    
    // function to display which pokemon are dead
    @IBAction func deadButton(_ sender: Any) {
        // gets all the pokemon that are dead
        var dead: [String] = []
        for i in 0...nuzPokemon.count - 1{
            if nuzPokemon[i] != "" && nuzDead[i] == true {
                dead.append(nuzPokemon[i])
            }
        }
        // sends alert with information
        let controller = UIAlertController(
            title: "Pokemon That Died",
            message: dead.joined(separator: ", "),
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .default))
        present(controller, animated: true)
    }
}
