//
//  CreateEmployeeViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: UIViewController {
    weak var coordinator: EmployeeEditorCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColourScheme.tableViewBackgroundColour
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onCancelPressed))
        navigationItem.title = "Create Employee"
    }
    
    @objc private func onCancelPressed() {
        dismiss(animated: true, completion: nil)
        coordinator?.done()
    }
}
