//
//  CustomViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarStyle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func setUpNavigationBarStyle() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 3.0
        navigationBar.layer.shadowOpacity = 0.3
        navigationBar.layer.masksToBounds = false
        navigationBar.barTintColor = ColourScheme.navigationBarColour
        navigationBar.tintColor = ColourScheme.navigationTintColour
        navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
}
