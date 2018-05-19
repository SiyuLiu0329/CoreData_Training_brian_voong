//
//  EmployeesTableViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 17/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class EmployeesTableViewController: UITableViewController {
    
    var company: TempCompany?
    weak var coordinator: Coorinator?
    
    init(company: TempCompany) {
        super.init(nibName: nil, bundle: nil)
        self.company = company
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }

    private func setUpNavBar() {
        guard let company = company else { return }
        navigationItem.title = company.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddPressed))
    }
    
    @objc private func onAddPressed() {
        coordinator?.createEmployee()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
