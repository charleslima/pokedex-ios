//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationControllerAppearance()
    }
    
    private func setupNavigationControllerAppearance() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let emptyButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = emptyButton
    }
}
