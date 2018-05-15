//
//  CompanyTableViewCell.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 15/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCompany(_ company: Company) {
        guard let date = company.founded,
        let name = company.name else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        textLabel?.text = "\(name) - Founded: \(dateFormatter.string(from: date))"
    }

}
