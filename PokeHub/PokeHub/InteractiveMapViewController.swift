// Names: Albertus Laksana, Brandon Nguyen, Proma Saha, Tran La
// Project Name: Pokehub
// Group Number: Team 9
//
//
//  InteractiveMapViewController.swift
//  PokeHub
//
//  Created by Albertus Laksana on 3/3/23.
//

import UIKit

// Code for interactive map
class InteractiveMapViewController: UIViewController, UIScrollViewDelegate {
    
    // all buttons for the locations on the map
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var button6 = UIButton()
    var button7 = UIButton()
    var button8 = UIButton()
    var button9 = UIButton()
    var button10 = UIButton()
    var button11 = UIButton()
    var button12 = UIButton()
    var button13 = UIButton()
    var button14 = UIButton()
    var button15 = UIButton()
    var button16 = UIButton()
    
    // initializes initial view
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: UIImage(named: "Map.png"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.contentOffset = CGPoint(x:256, y:200)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        
        // South Province Area 1
        let markerImage = UIImage(named: "Marker.png")
        button1.tag = 0
        button1.setImage(markerImage, for: .normal)
        button1.frame = CGRect(x: 493, y: 888, width: 50, height: 50)
        button1.backgroundColor = UIColor.clear
        button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button1)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // South Province Area 2
        button2.tag = 1
        button2.setImage(markerImage, for: .normal)
        button2.frame = CGRect(x: 322, y: 781, width: 50, height: 50)
        button2.backgroundColor = UIColor.clear
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button2)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // South Province Area 3
        button3.tag = 2
        button3.setImage(markerImage, for: .normal)
        button3.frame = CGRect(x: 633, y: 743, width: 50, height: 50)
        button3.backgroundColor = UIColor.clear
        button3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button3)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // South Province Area 4
        button4.tag = 3
        button4.setImage(markerImage, for: .normal)
        button4.frame = CGRect(x: 365, y: 881, width: 50, height: 50)
        button4.backgroundColor = UIColor.clear
        button4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button4)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // South Province Area 5
        button5.tag = 4
        button5.setImage(markerImage, for: .normal)
        button5.frame = CGRect(x: 625, y: 847, width: 50, height: 50)
        button5.backgroundColor = UIColor.clear
        button5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button5)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // East Province Area 1
        button6.tag = 5
        button6.setImage(markerImage, for: .normal)
        button6.frame = CGRect(x: 809, y: 738, width: 50, height: 50)
        button6.backgroundColor = UIColor.clear
        button6.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button6)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // East Province Area 2
        button7.tag = 6
        button7.setImage(markerImage, for: .normal)
        button7.frame = CGRect(x: 790, y: 633, width: 50, height: 50)
        button7.backgroundColor = UIColor.clear
        button7.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button7)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // East Province Area 3
        button8.tag = 7
        button8.setImage(markerImage, for: .normal)
        button8.frame = CGRect(x: 758, y: 494, width: 50, height: 50)
        button8.backgroundColor = UIColor.clear
        button8.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button8)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // West Province Area 1
        button9.tag = 8
        button9.setImage(markerImage, for: .normal)
        button9.frame = CGRect(x: 185, y: 648, width: 50, height: 50)
        button9.backgroundColor = UIColor.clear
        button9.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button9)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // West Province Area 2
        button10.tag = 9
        button10.setImage(markerImage, for: .normal)
        button10.frame = CGRect(x: 207, y: 446, width: 50, height: 50)
        button10.backgroundColor = UIColor.clear
        button10.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button10)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // West Province Area 3
        button11.tag = 10
        button11.setImage(markerImage, for: .normal)
        button11.frame = CGRect(x: 398, y: 445, width: 50, height: 50)
        button11.backgroundColor = UIColor.clear
        button11.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button11)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // North Province Area 1
        button12.tag = 11
        button12.setImage(markerImage, for: .normal)
        button12.frame = CGRect(x: 749, y: 295, width: 50, height: 50)
        button12.backgroundColor = UIColor.clear
        button12.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button12)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // North Province Area 2
        button13.tag = 12
        button13.setImage(markerImage, for: .normal)
        button13.frame = CGRect(x: 844, y: 393, width: 50, height: 50)
        button13.backgroundColor = UIColor.clear
        button13.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button13)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // North Province Area 3
        button14.tag = 13
        button14.setImage(markerImage, for: .normal)
        button14.frame = CGRect(x: 461, y: 166, width: 50, height: 50)
        button14.backgroundColor = UIColor.clear
        button14.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button14)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // Glaseado Mountain
        button15.tag = 14
        button15.setImage(markerImage, for: .normal)
        button15.frame = CGRect(x: 579, y: 286, width: 50, height: 50)
        button15.backgroundColor = UIColor.clear
        button15.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button15)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        // Asado Desert
        button16.tag = 15
        button16.setImage(markerImage, for: .normal)
        button16.frame = CGRect(x: 187, y: 545, width: 50, height: 50)
        button16.backgroundColor = UIColor.clear
        button16.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(button16)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    // function to display pokemon at each location
    @objc func buttonAction(sender: UIButton!) {
        switch sender.tag {
        default:
            let controller = UIAlertController(
                title: locations[sender.tag],
                message: pokeLocation[sender.tag],
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .default))
            present(controller, animated: true)
        }
    }
    
    // function to allow zooming in image view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
