// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  TableViewCell.swift
//  PokeHub
//
//  Created by Brandon Nguyen on 3/7/23.
//

import UIKit

// Class for custom cells and pokedex view controller
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capButton: UIButton!
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var shinyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
