//
//  EmployeesModel.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import CoreData

class EmployeesModel {
    let context = ContextManager.shared.persistentContainer.viewContext
    var employees = [Employee]()
    var company: Company
    
    init(for company: Company) {
        self.company = company
    }
    
    var numberOfEmployees: Int {
        return employees.count
    }
    
    func insertEmployee(employee: TempEmployee) {
        let emp = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        let empInfo = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInfo", into: context) as! EmployeeInfo
        emp.name = employee.name
        empInfo.taxId = "456"
        emp.employeeInformation = empInfo
        emp.company = company
        
        saveContext()
        fetchEmployees()
    }
    
    func fetchEmployees() {
        employees = company.employees?.allObjects as! [Employee]
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
}
