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
        let insertionResult = model.insertEmployee(employee: employeeData)
        if insertionResult.newGroup {
            tableView.insertSections([insertionResult.groupIndex], with: .automatic)
        } else {
            tableView.insertRows(at: [IndexPath(row: insertionResult.empIndex, section: insertionResult.groupIndex)], with: .automatic)
        }
        
        
//        tableView.insertRows(at: [IndexPath(row: model.numberOfEmployees - 1, section: 0)], with: .automatic)
    }
}
