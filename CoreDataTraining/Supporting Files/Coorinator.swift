//
//  Coorinator.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 13/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import UIKit

protocol BaseCoordinator {
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class Coorinator: NSObject, BaseCoordinator {
    func start() {
        let vc = CompaniesTableViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func editCompany(delegate: CreateCompanyDelegate?, companyToEdit: Company) {
        let editController = CreateCompanyViewController(companyToEdit: companyToEdit)
        let navController = CustomNavigationViewController(rootViewController: editController)
        editController.delegate = delegate
        navigationController.present(navController, animated: true, completion: nil)
    }
    
    func createCompany(delegate: CreateCompanyDelegate?) {
        let createCompanyViewController = CreateCompanyViewController()
        createCompanyViewController.coordinator = self
        createCompanyViewController.delegate = delegate
        let navController = CustomNavigationViewController (rootViewController: createCompanyViewController)
        navigationController.present(navController, animated: true, completion: nil)
    }
}
