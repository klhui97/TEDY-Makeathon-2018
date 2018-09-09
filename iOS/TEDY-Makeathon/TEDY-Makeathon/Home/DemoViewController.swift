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
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Icon.menu, style: .plain, target: self, action: #selector(showMenu))
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
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
