//
//  CreateEmployeeViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: UIViewController {
    weak var coordinator: EmployeeEditorCoordinator?
    let contentView: EmployeeEditorView = EmployeeEditorView()
    private let model = EmployeesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColourScheme.tableViewBackgroundColour
        setUpNavBar()
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            contentView.heightAnchor.constraint(equalToConstant: contentView.preferredHeight)
            ])
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onCancelPressed))
        navigationItem.title = "Create Employee"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.onSavePressed))
    }
    
    @objc private func onSavePressed() {
        guard let name = contentView.nameTextField.text else { return }
        guard !name.isEmpty  else { return }
        model.createEmployee(employee: TempEmployee(name: name))
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onCancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        coordinator?.done()
    }
}
