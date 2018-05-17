//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CompaniesTableViewController: UITableViewController {
    let cellId = "cellId"
    private var tableViewDataSource: UITableViewDataSource?
    let model = CompaniesModel()
    weak var coordinator: Coorinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpTableView()

    }
    
    private func setUpTableView() {
        tableView.backgroundColor = ColourScheme.tableViewBackgroundColour
        tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
        model.fetchCompanies()
    }
    
    private func setUpNavigationItem() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddPressed))
        navigationItem.title = "Companies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(self.onResetPressed))
        
    }
    
    @objc private func onResetPressed() {
        var indexPaths = [IndexPath]()
        for i in 0..<model.numberOfCompanies {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        model.resetDatabase()
        tableView.deleteRows(at: indexPaths, with: .left)

    }
    
    @objc private func onAddPressed() {
        guard coordinator != nil else { return }
        coordinator?.createCompany(delegate: self)
    }

}
