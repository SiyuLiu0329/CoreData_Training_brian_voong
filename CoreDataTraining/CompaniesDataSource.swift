//
//  CompaniesDataSource.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CompaniesDataSource: NSObject, UITableViewDataSource {
    private let cellId = "cellId"
    
    init(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
}
