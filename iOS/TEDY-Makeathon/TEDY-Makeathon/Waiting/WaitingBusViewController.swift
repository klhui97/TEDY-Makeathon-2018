//
//  WaitingBusViewController.swift
//  TEDY-Makeathon
//
//  Created by KL on 13/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class WaitingBusViewController: KLViewController {
    
    let stop: KMBData.RouteStop
    let showBusNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("顯示巴士號碼", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        button.setTitleColor(UIColor.blue, for: UIControlState())
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    init(stop: KMBData.RouteStop) {
        self.stop = stop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let firstEta = stop.eta?.first {
            SoundHelper.shared.speak("巴士到站時間為： " + firstEta.shortArrivalTime + "距離到站時間仲有1分鐘")
        }
        
        safeAreaContentView.add(showBusNumberButton)
        showBusNumberButton.al_centerToView()
        
        showBusNumberButton.addTarget(self, action: #selector(showBusNumberOnClicked), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = stop.cName
    }
    
    @objc func showBusNumberOnClicked() {
        navigationController?.pushViewController(BusNumberViewController(), animated: true)
    }
}
