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
    func didAddCompany(in object: TempCompany)
    func didEditCompany(atIndex index: Int, newData: TempCompany)
}

class CreateCompanyViewController: UIViewController {
    weak var coordinator: CompanyEditorCoordinator?
    weak var delegate: CreateCompanyDelegate?
    private var tempComany: TempCompany?
    private var companyIndex: Int?
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        return picker
    } ()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColourScheme.backgroundColour
        return view
    } ()
    
    var companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "select_photo_empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true // remember to do this
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    @objc private func onImageTapped(_ recogniser: UITapGestureRecognizer) {
        guard let coordinator = coordinator else { return }
        coordinator.presentImagePicker(delegate: self)
    }
    
    
    init(companyToEdit: TempCompany, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.tempComany = companyToEdit
        self.companyIndex = index
        unpackCompanyData()
    }
    
    private func unpackCompanyData() {
        guard let company = self.tempComany else { return }
        nameTextField.text = company.name
        datePicker.date = company.date
        companyImageView.image = company.image
    }
    
    private func packCompanyData() -> TempCompany? {
        guard let name = nameTextField.text else { return nil }
        guard !name.isEmpty else { return nil }
        let image = companyImageView.image ?? #imageLiteral(resourceName: "select_photo_empty")
        return TempCompany(name: name, date: datePicker.date, image: image)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColourScheme.tableViewBackgroundColour
    }
    
    
    @objc private func onCancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onSavePressed() {
        guard let delegate = delegate else { return }
        guard let data = packCompanyData() else { return }
        dismiss(animated: true) {
            delegate.didAddCompany(in: data)
        }
    }
    
    @objc private func onEditPressed() {
        guard let delegate = delegate else { return }
        guard let index = companyIndex else { return }
        guard let data = packCompanyData() else { return }
        dismiss(animated: true) {
            delegate.didEditCompany(atIndex: index, newData: data)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        coordinator?.done()
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onCancelPressed))
        if tempComany != nil {
            navigationController?.navigationBar.topItem?.title = "Edit Company"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.onEditPressed))
        } else {
            navigationController?.navigationBar.topItem?.title = "Create Company"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.onSavePressed))
        }
    }
}


extension CreateCompanyViewController {
    private func setUpUI() {
        companyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImageTapped(_:))))
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            ])
        
        contentView.addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            companyImageView.heightAnchor.constraint(equalToConstant: 100),
            companyImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            companyImageView.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
            nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor)
            ])
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            datePicker.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            datePicker.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
}

extension CreateCompanyViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            companyImageView.image = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            companyImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
