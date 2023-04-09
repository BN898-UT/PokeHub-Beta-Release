// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  SelectionViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// Code for selecting a pokemon for team builder
class SelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "SelectCell"
    var segueIdentifier = "SelectSegue"
    var chosenButton: UIButton!
    var delegate:UIViewController!
    var image:UIImageView!
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
    }
    
    //sets amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    //sets data in cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! SelectorTableViewCell
        let row = indexPath.row
        // code for custom cell images
        cell.cellImage.image = UIImage(named: pokemon[row])
        cell.nameLabel.text = pokemon[row]
        // cell.numLabel.text = "No. \(row + 1)"
        return cell
    }
    
    //gets pokemon selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pass over information once a pokemon is chosen
        let otherVC = delegate as! TextChanger
        otherVC.changeText(label: chosenButton, img:image, newPokemon: pokemon[indexPath.row])
        self.dismiss(animated: true)
    }
}
