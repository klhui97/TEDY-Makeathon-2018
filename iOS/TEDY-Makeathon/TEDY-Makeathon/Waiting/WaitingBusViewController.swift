//
//  WaitingBusViewController.swift
//  TEDY-Makeathon
//
//  Created by KL on 13/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class WaitingBusViewController: KLViewController {
    
    var timer = Timer()
    var timer2 = Timer()
    let stop: KMBData.RouteStop
    let showBusNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("顯示巴士號碼", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    let remainingTimeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.semibold)
        label.textAlignment = .center
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        label.textAlignment = .center
        return label
    }()
    
    init(stop: KMBData.RouteStop) {
        self.stop = stop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
        timer2.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabelOnly), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "往: " + stop.cName
        updateRemainingTimeLabel(showTips: true)
        
        safeAreaContentView.add(showBusNumberButton, remainingTimeLabel, titleLabel)
        
        let views = ["showBusNumberButton": showBusNumberButton,
                     "remainingTimeLabel": remainingTimeLabel,
                     "titleLabel": titleLabel]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[titleLabel]-16-[remainingTimeLabel(200)]-16-[showBusNumberButton(70)]", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-24-[showBusNumberButton]-24-|", options: [], metrics: nil, views: views))
        
        
        showBusNumberButton.addTarget(self, action: #selector(showBusNumberOnClicked), for: .touchUpInside)
    }
    
    func updateRemainingTimeLabel(showTips: Bool) {
        if let stopEta = stop.eta, stopEta.count > 0 {
            if let remainingTime = stopEta[0].remainingTime {
                if remainingTime.minute > 0 {
                    remainingTimeLabel.text = String(remainingTime.minute) + "分鐘" + String(remainingTime.second) + "秒"
                    remainingTimeLabel.accessibilityHint = "後到達"
                }else if remainingTime.second > 0 {
                    // Almost arrived
                    if showTips {
                        SoundHelper.shared.speak("巴士一分鐘內會到達 依家幫你顯示巴士號碼 請將屏幕反轉")
                        navigationController?.pushViewController(BusNumberViewController(), animated: true)
                    }
                    remainingTimeLabel.text = String(remainingTime.second) + "秒"
                    remainingTimeLabel.accessibilityHint = "巴士一分鐘內會到達"
                }else {
                    // Already arrived
                    remainingTimeLabel.text = "到達"
                    remainingTimeLabel.accessibilityHint = "巴士即將到站或已離開"
                }
            }
        }
    }
    
    @objc func updateLabelOnly() {
        updateRemainingTimeLabel(showTips: false)
    }
    
    @objc func updateTimer() {
        updateRemainingTimeLabel(showTips: true)
    }
    
    @objc func showBusNumberOnClicked() {
        navigationController?.pushViewController(BusNumberViewController(), animated: true)
    }
}
