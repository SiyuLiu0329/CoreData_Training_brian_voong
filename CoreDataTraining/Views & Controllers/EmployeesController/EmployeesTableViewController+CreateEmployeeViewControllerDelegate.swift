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
        model.insertEmployee(employee: employeeData)
        tableView.insertRows(at: [IndexPath(row: model.numberOfEmployees - 1, section: 0)], with: .automatic)
    }
}
