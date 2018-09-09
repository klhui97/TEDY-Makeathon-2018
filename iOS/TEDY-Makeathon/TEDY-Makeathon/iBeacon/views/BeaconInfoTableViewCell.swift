//
//  BeaconInfoTableViewCell.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class BeaconInfoTableViewCell: UITableViewCell {
    
    let beaconNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        return label
    }()
    
    let beaconAccuracyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    
    let lastUpdateTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    
    let statusColorView = CircleImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        statusColorView.backgroundColor = .red
        
        
        contentView.add(beaconNameLabel, beaconAccuracyLabel, lastUpdateTimeLabel, statusColorView)
        let views = ["beaconNameLabel": beaconNameLabel,
                     "beaconAccuracyLabel": beaconAccuracyLabel,
                     "lastUpdateTimeLabel": lastUpdateTimeLabel,
                     "statusColorView": statusColorView]
        
        NSLayoutConstraint.activateHighPriority(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[beaconNameLabel]-12-[beaconAccuracyLabel]-16-|", options: [.alignAllLeft], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[beaconNameLabel]-8-[statusColorView(12)]-16-|", options: [.alignAllCenterY], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "[beaconAccuracyLabel]-8-[lastUpdateTimeLabel(<=100)]", options: [.alignAllLastBaseline], metrics: nil, views: views))
        
        lastUpdateTimeLabel.al_rightToView(statusColorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
