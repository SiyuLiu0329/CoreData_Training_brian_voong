//
//  CompanyTableViewCell.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 15/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            guard let company = company else { return }
            guard let date = company.founded,
                let name = company.name else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            companyLabel.text = "\(name) - Founded: \(dateFormatter.string(from: date))"
            companyImageView.image = (company.imageData == nil) ? #imageLiteral(resourceName: "select_photo_empty") : UIImage(data: company.imageData!)
        }
    }
    
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    } ()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func layoutCell() {
        addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.heightAnchor.constraint(equalToConstant: 40),
            companyImageView.widthAnchor.constraint(equalToConstant: 40),
            companyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        addSubview(companyLabel)
        NSLayoutConstraint.activate([
            companyLabel.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 8),
            companyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8)
            ])
    }
}
