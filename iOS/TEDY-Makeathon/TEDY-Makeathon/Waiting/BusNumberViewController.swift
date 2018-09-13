//
//  BusNumberViewController.swift
//  TEDY-Makeathon
//
//  Created by KL on 14/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class BusNumberViewController: KLViewController {
    
    let busNumberLabel = UILabel()
    var originBrightness: CGFloat = 0.5
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIScreen.main.brightness = originBrightness
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        originBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = CGFloat(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.largeTitleDisplayMode = .never
        
        busNumberLabel.text = "2F"
        busNumberLabel.textAlignment = .center
        busNumberLabel.font = UIFont.systemFont(ofSize: 500, weight: UIFont.Weight.bold)
        busNumberLabel.adjustsFontSizeToFitWidth = true
        
        safeAreaContentView.add(busNumberLabel)
        busNumberLabel.al_fillSuperview()
    }
}
