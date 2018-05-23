//
//  EmployeesTableViewController+CreateEmployeeViewControllerDelegate.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation

extension EmployeesTableViewController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employeeData: TempEmployee) {
        guard let model = model else { return }
        model.insertEmployee(employee: employeeData)
        tableView.reloadData()
//        tableView.insertRows(at: [IndexPath(row: model.numberOfEmployees - 1, section: 0)], with: .automatic)
    }
}
