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
    var selectedEmpolyeeType: String? {
        if segmentedControl.selectedSegmentIndex == UISegmentedControlNoSegment {
            return nil
        }
        return segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    var birthday: Date {
        return birthdayPicker.date
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Executive", "Senior", "Staff"])
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.tintColor = ColourScheme.navigationBarColour
        return segControl
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Employee Name..."
        return textField
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birthday:"
        return label
    }()
    
    let birthdayPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
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
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
            ])
        
        
        addSubview(birthdayPicker)
        NSLayoutConstraint.activate([
            birthdayPicker.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            birthdayPicker.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            birthdayPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            birthdayPicker.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        addSubview(birthdayLabel)
        NSLayoutConstraint.activate([
            birthdayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            birthdayLabel.rightAnchor.constraint(equalTo: birthdayPicker.leftAnchor, constant: 8),
            birthdayLabel.centerYAnchor.constraint(equalTo: birthdayPicker.centerYAnchor)
            ])
    
        
        addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: birthdayPicker.bottomAnchor, constant:8),
            segmentedControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            segmentedControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
