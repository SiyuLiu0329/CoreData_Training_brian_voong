//
//  Coorinator.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

protocol BaseCoordinator: class {
    var childCoordinators: [BaseCoordinator] { get set }
    var parentCoordinator: BaseCoordinator? { get set }
    var presentor: CustomNavigationViewController { get set }
    func start()
}

extension BaseCoordinator {
    func done() {
        parentCoordinator?.removeChildCoordinator(child: self)
    }
    
    func removeChildCoordinator(child: BaseCoordinator) {
        childCoordinators = childCoordinators.filter({$0 !== child})
    }
    
    func addChildCoordinator(child: BaseCoordinator) {
        child.parentCoordinator = self
        childCoordinators.append(child)
    }
}

class Coorinator: NSObject, BaseCoordinator {
    var parentCoordinator: BaseCoordinator?
    func start() {
        let vc = CompaniesTableViewController()
        vc.coordinator = self
        presentor.pushViewController(vc, animated: true)
    }
    
    var childCoordinators: [BaseCoordinator] = []
    var presentor: CustomNavigationViewController
    
    init(presentor: CustomNavigationViewController) {
        self.presentor = presentor
    }
    
    func editCompany(delegate: CreateCompanyDelegate?, tempCompany: TempCompany, companyIndex: Int) {
        let editController = CreateCompanyViewController(companyToEdit: tempCompany, index: companyIndex)
        editController.delegate = delegate
        let navController = CustomNavigationViewController(rootViewController: editController)
        
        let childCoordinator = CompanyEditorCoordinator(presentor: navController)
        editController.coordinator = childCoordinator
        addChildCoordinator(child: childCoordinator)
        
        presentor.present(navController, animated: true, completion: nil)
        
        
    }
    
    func createCompany(delegate: CreateCompanyDelegate?) {
        let createCompanyViewController = CreateCompanyViewController()
        createCompanyViewController.delegate = delegate
        let navController = CustomNavigationViewController(rootViewController: createCompanyViewController)
        
        let childCoordinator = CompanyEditorCoordinator(presentor: navController)
        createCompanyViewController.coordinator = childCoordinator
        addChildCoordinator(child: childCoordinator)
        
        presentor.present(navController, animated: true, completion: nil)
        
    }
    

    
}

class CompanyEditorCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var parentCoordinator: BaseCoordinator?
    var presentor: CustomNavigationViewController
    func start() {}
    
    deinit {
        print("Child coordinator deinited: \(self)")
    }
    
    init(presentor: CustomNavigationViewController) {
        self.presentor = presentor
    }
    
    func presentImagePicker(delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? ) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        imagePicker.allowsEditing = true
        presentor.present(imagePicker, animated: true, completion: nil)
    }

}

