//
//  EmployeesTableViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 17/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class EmployeesTableViewController: UITableViewController {

    let cellId = "cellId"
    weak var coordinator: Coorinator?
    var model: EmployeesModel?
    
    init(company: Company) {
        super.init(nibName: nil, bundle: nil)
        model = EmployeesModel(for: company)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = ColourScheme.tableViewBackgroundColour
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.fetchEmployees()
        setUpNavBar()
    }

    private func setUpNavBar() {
        guard let model = model else { return }
        navigationItem.title = model.company.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddPressed))
    }
    
    @objc private func onAddPressed() {
        coordinator?.createEmployee(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



