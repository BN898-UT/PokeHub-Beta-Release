// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  LocationFinderViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// code for location finder
class LocationFinderViewController: UIViewController {

    //loads initial view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        // creates title for view controller
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:15, height: 10))
        imageView.contentMode = .scaleAspectFit
        let title = UIImage(named: "locationfinder.png")
        imageView.image = title
        self.navigationItem.titleView = imageView
    }
}
