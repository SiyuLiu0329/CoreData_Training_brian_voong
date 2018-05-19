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
    
    var numberOfEmployees: Int {
        return employees.count
    }
    
    func insertEmployee(employee: TempEmployee) {
        let e = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        e.setValue(employee.name, forKey: "name")
        saveContext()
        fetchEmployees()
    }
    
    func fetchEmployees() {
        do {
            employees = try context.fetch(Employee.fetchRequest())
        } catch let error {
            print(error)
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
}
