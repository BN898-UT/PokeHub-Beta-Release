// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  BattleTrackerViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// UI to implement battle tracker
class BattleTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "BattleCell"

    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //sets navigation controller color
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "battletracker.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        
        // sets status bar background color
        makeStatusBar(view: self.view)
        // Do any additional setup after loading the view.
    }
    
    // sets the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return battles.count
    }
    
    // sets the information in the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! BattleTrackerTableViewCell
        let row = indexPath.row
        //checks for number of pokemon in each team
        //if there is no pokemon in a slot, we set a default image
        cell.charImage.image = UIImage(named: battles[row])
        cell.pk1Image.image = UIImage(named: trainPokemon[row][0])
        if trainPokemon[row][1] != "" {
            cell.pk2Image.image = UIImage(named: trainPokemon[row][1])
        } else {
            cell.pk2Image.image = UIImage(named: "ball1")
        }
        if trainPokemon[row][2] != "" {
            cell.pk3Image.image = UIImage(named: trainPokemon[row][2])
        } else {
            cell.pk3Image.image = UIImage(named: "ball1")
        }
        if trainPokemon[row][3] != "" {
            cell.pk4Image.image = UIImage(named: trainPokemon[row][3])
        } else {
            cell.pk4Image.image = UIImage(named: "ball1")
        }
        if trainPokemon[row][4] != "" {
            cell.pk5Image.image = UIImage(named: trainPokemon[row][4])
        } else {
            cell.pk5Image.image = UIImage(named: "ball1")
        }
        if trainPokemon[row][5] != "" {
            cell.pk6Image.image = UIImage(named: trainPokemon[row][5])
        } else {
            cell.pk6Image.image = UIImage(named: "ball1")
        }
        cell.infoLabel.text = battles[row]
        return cell
    }
}
