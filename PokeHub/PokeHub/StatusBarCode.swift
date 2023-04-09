// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//  StatusBarCode.swift
//  PokeHub
//
//  Created by Brandon Nguyen on 4/5/23.
//

import Foundation
import UIKit

// extension to change status bar background color
extension UIViewController {
    func makeStatusBar(view:UIView) {
        // iOS version is >= 13.0
        if #available(iOS 13.0, *) {
            // make UIView and change status of it
            let statusBarHeight: CGFloat = 54.0
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.systemRed
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.systemRed
        }
    }
}
