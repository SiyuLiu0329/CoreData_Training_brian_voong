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
    var allEmployees: [(String, [Employee])] = []
    var company: Company
    
    init(for company: Company) {
        self.company = company
    }
    
    func insertEmployee(employee: TempEmployee) -> (groupIndex: Int, empIndex: Int, newGroup: Bool) {
        let emp = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        let empInfo = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInfo", into: context) as! EmployeeInfo
        emp.name = employee.name
        empInfo.taxId = "456"
        empInfo.birthday = employee.birthday
        emp.employeeInformation = empInfo
        emp.company = company
        emp.type = employee.type
        
        saveContext()
        if let i = allEmployees.index(where: {$0.0 == employee.type}) {
            allEmployees[i].1.insert(emp, at: 0)
            return (i, 0, false)
        }
        
        allEmployees.append((employee.type, [emp]))
        allEmployees.sort(by: {$0.0 < $1.0})
        print(allEmployees[allEmployees.index(where: {$0.0 == employee.type})!].1)
        
        return (allEmployees.index(where: {$0.0 == employee.type}) ?? 0, 0, true)
    }
    
    func fetchEmployees() {
        allEmployees = []
        let employees = company.employees?.allObjects as! [Employee]
        employees.forEach { (emp) in
            let type = emp.type ?? "Null"
            if let i = allEmployees.index(where: {$0.0 == type}) {
                allEmployees[i].1.append(emp)
            } else {
                allEmployees.insert((type, [emp]), at: 0)
            }
        }
        allEmployees.sort(by: {$0.0 < $1.0})
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
}
