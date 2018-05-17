//
//  CompaniesTableViewController+CreateCompanyViewControllerDelegate.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 17/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import UIKit

extension CompaniesTableViewController: CreateCompanyDelegate {
    func didAddCompany(in object: TempCompany) {
        model.insertCompany(in: object)
        tableView.insertRows(at: [IndexPath(row: model.numberOfCompanies - 1, section: 0)], with: .automatic)
    }
    
    func didEditCompany(atIndex index: Int, newData: TempCompany) {
        model.updateCompany(atIndex: index, newData: newData)
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .middle)
    }
}
