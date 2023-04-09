// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  PokedexViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// class to implement pokedex
class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segView: UISegmentedControl!
    
    let textCellIdentifier = "PokeCell"
    
    var onAll = true
    var onCap = false
    var onShiny = false
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        makeStatusBar(view: self.view)
        // Do any additional setup after loading the view.
    }
    
    //sets amount of rows based on segmented view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if onAll == true {
            return pokemon.count
        } else if onCap == true {
            return dexCaptured.count
        } else {
            return dexShiny.count
        }
    }
    
    //sets information in cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! TableViewCell
        let row = indexPath.row
        if onAll == true {
            cell.cellImage.image = UIImage(named: pokemon[row])
            cell.nameLabel.text = pokemon[row]
            cell.numLabel.text = "No. \(row + 1)"
            cell.capButton.isHidden = false
            cell.shinyButton.isHidden = false
            cell.capButton.tag = row
            if captured[row] == false {
                cell.capButton.setImage(noCapImg, for: .normal)
            } else {
                cell.capButton.setImage(capImg, for: .normal)
            }
            cell.capButton.frame = CGRect(x: 335, y: 23, width: 35, height: 35)
            cell.capButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            cell.shinyButton.tag = row
            if shiny[row] == false {
                cell.shinyButton.setImage(noShinyImg, for: .normal)
            } else {
                cell.shinyButton.setImage(shinyImg, for: .normal)
            }
            cell.shinyButton.addTarget(self, action: #selector(shinyButtonAction), for: .touchUpInside)
        } else if onCap == true {
            cell.cellImage.image = UIImage(named: dexCaptured[row])
            cell.nameLabel.text = dexCaptured[row]
            cell.numLabel.text = "No. \(pokemon.firstIndex(of: dexCaptured[row])! + 1)"
            cell.capButton.isHidden = true
            cell.shinyButton.isHidden = true
        } else if onShiny == true {
            cell.cellImage.image = UIImage(named: dexShiny[row])
            cell.nameLabel.text = dexShiny[row]
            cell.numLabel.text = "No. \(pokemon.firstIndex(of: dexShiny[row])! + 1)"
            cell.capButton.isHidden = true
            cell.shinyButton.isHidden = true
        }
        return cell
    }
    
    // functionality for shiny button
    @objc func shinyButtonAction(sender: UIButton!) {
        shiny[sender.tag] = !shiny[sender.tag]
        if shiny[sender.tag] == false {
            sender.setImage(noShinyImg, for: .normal)
            dexShiny.remove(at: dexShiny.firstIndex(of: dexShiny[sender.tag])!)
        } else {
            sender.setImage(shinyImg, for: .normal)
            dexShiny.append(pokemon[sender.tag])
        }
    }
    
    //funcionality for capture button
    @objc func buttonAction(sender: UIButton!) {
        captured[sender.tag] = !captured[sender.tag]
        if captured[sender.tag] == false {
            sender.setImage(noCapImg, for: .normal)
            dexCaptured.remove(at: dexCaptured.firstIndex(of: dexCaptured[sender.tag])!)
        } else {
            sender.setImage(capImg, for: .normal)
            dexCaptured.append(pokemon[sender.tag])
        }
        sender.frame = CGRect(x: 335, y: 23, width: 35, height: 35)
    }
    
    // move to info segue when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "InfoSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // pass over needed info to pokeon info page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoSegue",
           let destination = segue.destination as? PokemonInfoViewController,
           let pokeIndex = tableView.indexPathForSelectedRow?.row{
            if onAll == true {
                destination.pokeName = pokemon[pokeIndex]
                destination.dexNum = pokeIndex
            } else if onCap == true {
                destination.pokeName = dexCaptured[pokeIndex]
                destination.dexNum = pokemon.firstIndex(of: dexCaptured[pokeIndex])!
            } else if onShiny == true {
                destination.pokeName = dexShiny[pokeIndex]
                destination.dexNum = pokemon.firstIndex(of: dexShiny[pokeIndex])!
            }
        }
    }
    
    // functionality of segmented view
    @IBAction func onSegChange(_ sender: Any) {
        switch segView.selectedSegmentIndex {
        case 0:
            onAll = true
            onCap = false
            onShiny = false
            tableView.reloadData()
        case 1:
            onAll = false
            onCap = true
            onShiny = false
            // warning for no pokemon capture
            if dexCaptured.count == 0 {
                let controller = UIAlertController(
                    title: "ERROR: NO POKEMON CAPTURED",
                    message: "Please mark a Pokemon as captured to view",
                    preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .default))
                present(controller, animated: true)
            }
            tableView.reloadData()
        case 2:
            onAll = false
            onCap = false
            onShiny = true
            // warning for no pokemon shiny
            if dexShiny.count == 0 {
                let controller = UIAlertController(
                    title: "ERROR: NO POKEMON SHINY",
                    message: "Please mark a Pokemon as shiny to view",
                    preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .default))
                present(controller, animated: true)
            }
            tableView.reloadData()
        default:
            print("shouldn't happen")
        }
    }
}
