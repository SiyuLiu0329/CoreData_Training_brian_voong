//
//  CompaniesModel.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CompaniesModel {
    var companies: [Company]?
    private let context = CoreDataManager.shared.persistentContainer.viewContext
    var isDatabaseEmpty: Bool {
        guard let companies = companies else { return true }
        return companies.isEmpty
    }
    
    var numberOfCompanies: Int {
        return (companies == nil) ? 0 : companies!.count
    }
    
    func getCompany(index: Int) -> Company? {
        guard let companise = companies else { return nil }
        return companise[index]
    }
    
    func deleteCompany(index: Int) {
        guard let companies = companies else { return }
        context.delete(companies[index])
        saveContext()
        fetchCompanies()
    }
    
    func fetchCompanies() {
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
        } catch let fetchError {
            print(fetchError)
        }
    }
    
    func resetDatabase() {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
        } catch let error {
            fatalError("Error deleting: \(error)")
        }
        companies = []
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
    
    func updateCompany(atIndex index: Int, newData: TempCompany) {
        guard let company = getCompany(index: index) else { return }
        company.name = newData.name
        company.founded = newData.date
        company.imageData = UIImageJPEGRepresentation(newData.image, 0.8)
        saveContext()
    }
    
    func insertCompany(in object: TempCompany) {
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(object.name, forKey: "name")
        company.setValue(object.date, forKey: "founded")
        let data = UIImageJPEGRepresentation(object.image, 0.8)
        company.setValue(data, forKey: "imageData")
        saveContext()
        fetchCompanies()
    }
}
