//
//  DemoViewController.swift
//  TEDY-Makeathon
//
//  Created by KL on 7/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import Material

class DemoViewController: KLViewController, MenuTableViewControllerDelegate {
    
    let menuManager = MenuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuManager.setDelegate(delegate: self)
        initNavigation()
    }
    
    // MARK: - Init
    private func initNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Icon.menu, style: .plain, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.accessibilityValue = "選單"
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.accessibilityHint = ""
    }
    
    @objc func showMenu() {
        menuManager.showMenu()
    }
    
    // MARK: - MenuTableViewControllerDelegate
    func changeViewController(toController: UIViewController) {
        menuManager.removeMenu(duration: 0.1, completion: {
            self.navigationController?.pushViewController(toController, animated: true)
        })
    }
}
