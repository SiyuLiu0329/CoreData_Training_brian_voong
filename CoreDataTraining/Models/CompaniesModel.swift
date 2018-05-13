//
//  CompaniesModel.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import CoreData

class CompaniesModel {
    var companies: [Company]?
    private let context = CoreDataManager.shared.persistentContainer.viewContext
    
    var numberOfCompanies: Int {
        return (companies == nil) ? 0 : companies!.count
    }
    
    func getCompany(index: Int) -> Company? {
        guard let companise = companies else { return nil }
        return companise[index]
    }
    
    func deleteCompany(index: Int) {
        guard let companies = companies else { return }
//        let context = CoreDataManager.shared.persistentContainer.viewContext // need a shared context for data to be displayed properly
        context.delete(companies[index])
        saveContext()
        fetchCompanies()
    }
    
    func fetchCompanies() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext // need a shared context for data to be displayed properly
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
        } catch let fetchError {
            print(fetchError)
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
    
    func updateCompany(_ company: Company, newData: CompanyDataFlow) {
        company.name = newData.name
        saveContext()
    }
    
    func insertCompany(in object: CompanyDataFlow) {
//        let context = CoreDataManager.shared.persistentContainer.viewContext // need a shared context for data to be displayed properly
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(object.name, forKey: "name")
        saveContext()
        fetchCompanies()
    }
}
