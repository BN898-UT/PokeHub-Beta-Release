// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  TeamBuilderViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import PokemonAPI

// Protocol to change teams and images, will move to separate file later
protocol TextChanger{
    func changeText(label:UIButton, img:UIImageView, newPokemon:String)
}

// Method to implement team builder
class TeamBuilderViewController: UIViewController, TextChanger {
    
    @IBOutlet weak var firstLabel: UIButton!
    @IBOutlet weak var secondLabel: UIButton!
    @IBOutlet weak var thirdLabel: UIButton!
    @IBOutlet weak var fourthLabel: UIButton!
    @IBOutlet weak var fifthLabel: UIButton!
    @IBOutlet weak var sixthLabel: UIButton!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var fifthImage: UIImageView!
    @IBOutlet weak var sixthImage: UIImageView!
    
    // loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "teambuilder.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
        makeStatusBar(view: self.view)
    }
    
    // Method to change image and pokemon name in VC
    func changeText(label: UIButton, img:UIImageView, newPokemon: String) {
        label.setTitle(newPokemon, for: .normal)
        img.image = UIImage(named: newPokemon)
    }
    
    // Multiple segues passing delegates to later edit pokemon name and image
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = firstLabel
            destination.image = firstImage
        }
        if segue.identifier == "SecondPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = secondLabel
            destination.image = secondImage
        }
        if segue.identifier == "ThirdPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = thirdLabel
            destination.image = thirdImage
        }
        if segue.identifier == "FourthPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = fourthLabel
            destination.image = fourthImage
        }
        if segue.identifier == "FifthPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = fifthLabel
            destination.image = fifthImage
        }
        if segue.identifier == "SixthPokemonSegue",
           let destination = segue.destination as? SelectionViewController {
            destination.delegate = self
            destination.chosenButton = sixthLabel
            destination.image = sixthImage
        }
    }
    
    //functionality of weaknes button
    @IBAction func buttonWeak(_ sender: Any) {
        var pokemonAmt = 0
        for i in 0...team.count-1{
            if team[i] != -1{
                pokemonAmt += 1
            }
        }
        if pokemonAmt == 0 {
            let controller = UIAlertController(
                title: "ERROR: NO POKEMON IN TEAM",
                message: "Please add a Pokemon on your team before viewing weaknesses",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .default))
            present(controller, animated: true)
        }
    }
    
    // functionality of effectiveness button
    @IBAction func buttonEffect(_ sender: Any) {
        var pokemonAmt = 0
        for i in 0...team.count-1{
            if team[i] != -1{
                pokemonAmt += 1
            }
        }
        if pokemonAmt == 0 {
            let controller = UIAlertController(
                title: "ERROR: NO POKEMON IN TEAM",
                message: "Please add a Pokemon on your team before viewing effectiveness",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .default))
            present(controller, animated: true)
        }
    }
    
    //function to save team
    @IBAction func saveTeam(_ sender: Any) {
        teamType1 = []
        teamType2 = []
        if firstLabel.currentTitle == nil {
            team[0] = -1
        }else{
            team[0] = pokemon.firstIndex(of: firstLabel.currentTitle!)!
        }
        if secondLabel.currentTitle ==  nil {
            team[1] = -1
        }else{
            team[1] = pokemon.firstIndex(of: secondLabel.currentTitle!)!
        }
        if thirdLabel.currentTitle ==  nil {
            team[2] = -1
        }else{
            team[2] = pokemon.firstIndex(of: thirdLabel.currentTitle!)!
        }
        if fourthLabel.currentTitle ==  nil {
            team[3] = -1
        }else{
            team[3] = pokemon.firstIndex(of: fourthLabel.currentTitle!)!
        }
        if fifthLabel.currentTitle ==  nil {
            team[4] = -1
        }else{
            team[4] = pokemon.firstIndex(of: fifthLabel.currentTitle!)!
        }
        if sixthLabel.currentTitle ==  nil {
            team[5] = -1
        }else{
            team[5] = pokemon.firstIndex(of: sixthLabel.currentTitle!)!
        }
        for i in 0...5 {
            let semaphore = DispatchSemaphore(value: 0)
            if team[i] != -1 {
                PokemonAPI().pokemonService.fetchPokemon(pokemon[team[i]].lowercased()) { result in
                    switch result {
                    case .success(let pokedex):
                        self.changeType(types: pokedex.types!)
                        semaphore.signal()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                let _ = semaphore.wait(timeout: .now() + 10.0)
            } else {
                teamType1.append("none")
                teamType2.append("none")
            }
        }
    }
    
    //function to get pokemon type
    func changeType(types:[PKMPokemonType]) {
        teamType1.append(types[0].type!.name!)
        let count = types.count
        if count > 1 {
            teamType2.append(types[1].type!.name!)
        } else {
            teamType2.append("none")
        }
    }
}
