//
//  EmployeeEditorView.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class EmployeeEditorView: UIView {
    let preferredHeight: CGFloat = 200
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Employee Name..."
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.topAnchor.constraint(equalTo: topAnchor)
            ])
        
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
