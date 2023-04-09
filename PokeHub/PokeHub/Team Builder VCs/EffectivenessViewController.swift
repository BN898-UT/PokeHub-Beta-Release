// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  EffectivenessViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit
import PokemonAPI

// code for effectiveness VC
class EffectivenessViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    var effectiveness:[Double] = []
    var allPokemonEffectiveness:[[Double]] = []
    var final:[String] = []
    var transposed:[[Double]] = []
    var pokemonAmt = 0
    var lastColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArray()
        collectionView.dataSource = self
        collectionView.delegate = self
        makeStatusBar(view: self.view)
    }
    
    // sets amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.final.count
    }
    
    // sets information of cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "effectiveCell", for: indexPath) as! EffectivenessCollectionViewCell
        cell.label.text = self.final[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        let cellName = self.final[indexPath.row]
        if cellName == "" {
            lastColor = .white
            cell.backgroundColor = .white
        } else if cellName == "fire" {
            lastColor = colorFire
            cell.backgroundColor = colorFire
        } else if cellName == "normal" {
            lastColor = colorNormal
            cell.backgroundColor = colorNormal
        } else if cellName == "water" {
            lastColor = colorWater
            cell.backgroundColor = colorWater
        } else if cellName == "electric" {
            lastColor = colorElectric
            cell.backgroundColor = colorElectric
        } else if cellName == "grass" {
            lastColor = colorGrass
            cell.backgroundColor = colorGrass
        } else if cellName == "ice" {
            lastColor = colorIce
            cell.backgroundColor = colorIce
        } else if cellName == "fighting" {
            lastColor = colorFighting
            cell.backgroundColor = colorFighting
        } else if cellName == "poison" {
            lastColor = colorPoison
            cell.backgroundColor = colorPoison
        } else if cellName == "rock" {
            lastColor = colorRock
            cell.backgroundColor = colorRock
        } else if cellName == "ground" {
            lastColor = colorGround
            cell.backgroundColor = colorGround
        } else if cellName == "flying" {
            lastColor = colorFlying
            cell.backgroundColor = colorFlying
        } else if cellName == "psychic" {
            lastColor = colorPsychic
            cell.backgroundColor = colorPsychic
        } else if cellName == "bug" {
            lastColor = colorBug
            cell.backgroundColor = colorBug
        } else if cellName == "ghost" {
            lastColor = colorGhost
            cell.backgroundColor = colorGhost
        } else if cellName == "dragon" {
            lastColor = colorDragon
            cell.backgroundColor = colorDragon
        } else if cellName == "dark" {
            lastColor = colorDark
            cell.backgroundColor = colorDark
        } else if cellName == "steel" {
            lastColor = colorSteel
            cell.backgroundColor = colorSteel
        } else if cellName == "fairy" {
            lastColor = colorFairy
            cell.backgroundColor = colorFairy
        } else {
            cell.backgroundColor = lastColor
        }
        cell.layer.masksToBounds = false
        return cell
    }
    
    // formats the cells
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if pokemonAmt <= 3 {
            collectionView.frame.size.width = 390
        } else {
            collectionView.frame.size.width = 790
        }
        collectionView.delaysContentTouches = true
        scrollView.contentSize = collectionView.frame.size;
        let layout = UICollectionViewFlowLayout()
        let containerWidth = collectionView.bounds.width
        var cellSize = 0
        if pokemonAmt != 0 {
            cellSize =  Int(containerWidth) / (pokemonAmt + 1)
        } else {
            cellSize =  Int(containerWidth) / 1
        }
        layout.itemSize = CGSize(width:cellSize,height:cellSize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        collectionView.collectionViewLayout = layout
    }
    
    //creates array for collection cells
    func createArray(){
        //pokemon at that index
        final.append("")
        for i in 0...team.count-1{
            if team[i] != -1{
                pokemonAmt += 1
                final.append(pokemon[team[i]])
            }
        }
        //creates effectiveness array for every pokemon
        for i in 0...team.count-1{
            //for every time
            effectiveness = []
            if team[i] != -1{
                for k in 0...18{
                    effectiveness.append(effectivenessMatrix[ types.firstIndex(of: teamType1[i])!][k] * effectivenessMatrix[types.firstIndex(of: teamType2[i])!][k])
                }
                allPokemonEffectiveness.append(effectiveness)
            }
        }
        //transposed array to fit collections format
        for i in 0...17{
            final.append(types[i])
            for j in 0...allPokemonEffectiveness.count-1{
                final.append(String(allPokemonEffectiveness[j][i]))
            }
        }
    }
}
