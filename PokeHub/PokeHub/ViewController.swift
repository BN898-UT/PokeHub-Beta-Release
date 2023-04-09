// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  ViewController.swift
//  PokeHub
//
//  Created by Brandon Nguyen on 2/22/23.
//

import UIKit
import Firebase

var ref: DatabaseReference!

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        navigationController?.navigationBar.backgroundColor = UIColor.systemRed
        //for database usage
    }
}

