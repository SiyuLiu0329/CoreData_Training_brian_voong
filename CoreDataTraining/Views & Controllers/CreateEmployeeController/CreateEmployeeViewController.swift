//
//  CreateEmployeeViewController.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate: class {
    func didAddEmployee(employeeData: TempEmployee)
}

class CreateEmployeeViewController: UIViewController {
    weak var coordinator: EmployeeEditorCoordinator?
    weak var delegate: CreateEmployeeControllerDelegate?
    let contentView: EmployeeEditorView = EmployeeEditorView()
    
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
        guard let delegate = delegate else { return }
        guard let selectedEmployeeType = contentView.selectedEmpolyeeType else { return }
        print(selectedEmployeeType)
        dismiss(animated: true) {
            delegate.didAddEmployee(employeeData: TempEmployee(name: name, birthday: self.contentView.birthday, type: selectedEmployeeType))
        }
    }
    
    @objc private func onCancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        coordinator?.done()
    }
}
