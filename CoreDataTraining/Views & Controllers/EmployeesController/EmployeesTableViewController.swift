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
    let cellId = "cellId"
    weak var coordinator: Coorinator?
    private let model = EmployeesModel()
    
    init(company: TempCompany) {
        super.init(nibName: nil, bundle: nil)
        self.company = company
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = ColourScheme.tableViewBackgroundColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.fetchEmployees()
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
        coordinator?.createEmployee(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmployeesTableViewController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employeeData: TempEmployee) {
        model.insertEmployee(employee: employeeData)
        tableView.insertRows(at: [IndexPath(row: model.numberOfEmployees - 1, section: 0)], with: .automatic)
    }
}

extension EmployeesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfEmployees
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = model.employees[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Employees"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
