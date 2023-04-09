// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  NuzlockeTableViewCell.swift
//  PokeHub
//
//  Created by Albertus Laksana on 4/3/23.
//

import UIKit

class NuzlockeTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var pokemonLabel: UITextField!
    @IBOutlet weak var nicknameLabel: UITextField!
    @IBOutlet weak var caughtButton: UIButton!
    @IBOutlet weak var deathButton: UIButton!
    
    var index:Int?
    var pokePicker = UIPickerView()
    
    //initialization of cell
    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonLabel.inputView = pokePicker
        pokePicker.dataSource = self
        pokePicker.delegate = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: pokePicker.frame.size.width, height: 40))
        toolbar.tintColor = UIColor.black
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        pokemonLabel.inputAccessoryView = toolbar
    }

    //functionality for done button in picker
    @objc func doneButtonAction(sender: UIBarButtonItem) {
        pokemonLabel.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // sets number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // sets amount of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokemon.count
    }
    
    // sets name of rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemon[row]
    }
    
    // grabs pokemon at row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokemonLabel.text = pokemon[row]
        nuzPokemon[index!] = pokemon[row]
    }
}
