//
//  CompaniesTableViewController+UITableViewControllerDelegate.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 17/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import UIKit

extension CompaniesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let company = model.getCompany(index: indexPath.row) else { return }
        
        guard let name = company.name,
            let date = company.founded,
            let imageData = company.imageData,
            let image = UIImage(data: imageData) else { return }
        
        let tempCompany = TempCompany(name: name, date: date, image: image)
        coordinator?.showEmployees(for: tempCompany)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfCompanies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyTableViewCell
        cell.company = model.getCompany(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = model.numberOfCompanies
        if count == 0 {
            return ""
        }
        
        return "\(count) " + (count == 1 ? "Company" : "Companies")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.model.deleteCompany(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.reloadHeader()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, indexPath) in
            guard let companies = self.model.companies else { return }
            let company = companies[indexPath.row]
            var image: UIImage? = nil
            if let data = company.imageData {
                image = UIImage(data: data)
            }
            let tempCompany = TempCompany(name: company.name!, date: company.founded!, image: image ?? #imageLiteral(resourceName: "select_photo_empty"))
            self.coordinator?.editCompany(delegate: self, tempCompany: tempCompany, companyIndex: indexPath.row)
        }
        
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return model.isDatabaseEmpty ? 150 : 0
    }
}
