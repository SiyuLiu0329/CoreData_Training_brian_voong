//
//  CreateCompanyViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyDelegate: class {
    func didAddCompany(in object: CompanyDataFlow)
    func didEditCompany(_ company: Company, newData: CompanyDataFlow)
}

class CreateCompanyViewController: UIViewController {
    weak var coordinator: Coorinator?
    weak var delegate: CreateCompanyDelegate?
    private var companyToEdit: Company?
    
    init(companyToEdit: Company) {
        super.init(nibName: nil, bundle: nil)
        self.companyToEdit = companyToEdit
        unpackCompanyData()
    }
    
    private func unpackCompanyData() {
        guard let company = self.companyToEdit else { return }
        nameTextField.text = company.name
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
        setUpUI()
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Text"
        label.backgroundColor = .clear
        return label
    } ()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name..."
        return textField
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColourScheme.tableViewBackgroundColour
    }
    
    @objc private func onCancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onSavePressed() {
        guard let name = nameTextField.text else { return }
        guard !name.isEmpty else { return }
        guard let delegate = delegate else { return }
        dismiss(animated: true) {
            delegate.didAddCompany(in: CompanyDataFlow(name: name))
        }
    }
    
    @objc private func onEditPressed() {
        guard let name = nameTextField.text else { return }
        guard !name.isEmpty else { return }
        guard let delegate = delegate else { return }
        guard let company = companyToEdit else { return }        
        dismiss(animated: true) {
            delegate.didEditCompany(company, newData: CompanyDataFlow(name: name))
        }
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onCancelPressed))
        if companyToEdit != nil {
            navigationController?.navigationBar.topItem?.title = "Edit Company"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.onEditPressed))
        } else {
            navigationController?.navigationBar.topItem?.title = "Create Company"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.onSavePressed))
        }
    }
    
    private func setUpUI() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
        
    }

}
