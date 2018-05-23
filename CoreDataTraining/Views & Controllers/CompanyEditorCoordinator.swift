//
//  CompanyEditorCoordinator.swift
//  CoreDataTraining
//
//  Created by Siyu Liu on 19/5/18.
//  Copyright © 2018 Siyu Liu. All rights reserved.
//

import Foundation
import UIKit

class CompanyEditorCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var parentCoordinator: BaseCoordinator?
    var presentor: CustomNavigationViewController
    func start() {}
    
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
