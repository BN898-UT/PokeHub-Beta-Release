// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  BattleTrackerTableViewCell.swift
//  PokeHub
//
//  Created by Tran La on 3/9/23.
//

import UIKit

class BattleTrackerTableViewCell: UITableViewCell {

    //create outlets to cell elements
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var pk1Image: UIImageView!
    @IBOutlet weak var pk2Image: UIImageView!
    @IBOutlet weak var pk3Image: UIImageView!
    @IBOutlet weak var pk4Image: UIImageView!
    @IBOutlet weak var pk5Image: UIImageView!
    @IBOutlet weak var pk6Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
