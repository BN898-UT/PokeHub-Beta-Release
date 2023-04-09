// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  PokemonInfoViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import PokemonAPI
import UIKit

class PokemonInfoViewController: UIViewController {
    
    @IBOutlet weak var pokeLabel: UILabel!
    @IBOutlet weak var dexIndex: UILabel!
    @IBOutlet weak var pokeDescription: UILabel!
    
    var pokemonImage: UIImageView!
    var pokeName = ""
    var dexNum = 0
    var count = 0
    var type1 = ""
    var type2 = ""
    var type1Img = UIImageView(frame: CGRect(x: 255, y: 381, width: 200, height: 44))
    var type2Img = UIImageView(frame: CGRect(x: 255, y: 479, width: 200, height: 44))
    
    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        makeStatusBar(view: self.view)
        var dot: UIView!
        dot = UIView(frame: CGRect(x: 120, y: 106, width: 188, height: 188))
        dot.layer.cornerRadius = 50
        dot.backgroundColor = .gray
        self.view.addSubview(dot)
        pokeLabel.backgroundColor = .red
        dexIndex.backgroundColor = .red
        pokeLabel.layer.masksToBounds = true
        dexIndex.layer.masksToBounds = true
        pokeLabel.layer.cornerRadius = 20
        dexIndex.layer.cornerRadius = 20
        pokeLabel.text = pokeName
        pokeDescription.layer.masksToBounds = true
        pokeDescription.layer.cornerRadius = 8
        pokeDescription.text = descriptions[dexNum]
        pokeDescription.numberOfLines = 8
        dexIndex.text = "No. \(dexNum + 1)"
        pokemonImage = UIImageView(frame: CGRect(x: 0, y: -20, width: 188, height: 188))
        pokemonImage.image = UIImage(named: pokeName)
        dot.addSubview(pokemonImage)
        // semphore to bypass sync issues
        let semaphore = DispatchSemaphore(value: 0)
        // grab data from pokemonAPI
        PokemonAPI().pokemonService.fetchPokemon(pokeName.lowercased()) { result in
            switch result {
            case .success(let pokedex):
                self.changeType(types: pokedex.types!)
                semaphore.signal()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        let _ = semaphore.wait(timeout: .now() + 10.0)
        type1Img.image = UIImage(named: type1)
        self.view.addSubview(type1Img)
        if count > 1 {
            type2Img.image = UIImage(named: type2)
            self.view.addSubview(type2Img)
        }
    }
    
    // set pokemon type
    func changeType(types:[PKMPokemonType]) {
        self.type1 = types[0].type!.name!
        self.count = types.count
        if self.count > 1 {
            self.type2 = types[1].type!.name!
        }
    }
}
