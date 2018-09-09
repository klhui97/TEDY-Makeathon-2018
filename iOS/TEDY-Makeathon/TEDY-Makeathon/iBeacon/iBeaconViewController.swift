//
//  iBeaconViewController.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class iBeaconViewController: KLViewController {
    
    let beaconManager = BeaconManager()
    let tableView = UITableView()
    
    deinit {
        print("iBeaconViewController deinited")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconManager.delegate = self
        initTableView()
        initTargetBeanconList()
        startMonitoringBeacons()
    }
    
    // MARK: - Init
    func initTargetBeanconList() {
        beaconManager.targetBeacons.append(BeaconModel(uuid: UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")!, identifier: "beacon1"))
        beaconManager.targetBeacons.append(BeaconModel(uuid: UUID(uuidString: "1f4260cf-d5dc-477c-b058-ebfe622e5d08")!, identifier: "beacon2"))
    }
    
    func initTableView() {
        safeAreaContentView.add(tableView)
        tableView.al_fillSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        
        tableView.register(BeaconInfoTableViewCell.self)
    }
    
    // MARK: - Method
    func startMonitoringBeacons() {
        beaconManager.monitorAllTargetBeacons()
    }
}

// MARL: - BeaconManagerDelegate

extension iBeaconViewController: BeaconManagerDelegate {
    func didUpdateBeacon(for index: Int) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
}

// MARK: - TableView delegate and datasource

extension iBeaconViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconManager.targetBeacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BeaconInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let beaconModel = beaconManager.targetBeacons[indexPath.row]
        
        cell.beaconNameLabel.text = beaconModel.identifier
        
        if beaconModel.isUnknown {
            cell.statusColorView.backgroundColor = .red
        }else {
            cell.statusColorView.backgroundColor = .green
            
        }
        
        cell.beaconAccuracyLabel.text = beaconModel.accuracy?.description
        cell.lastUpdateTimeLabel.text = beaconModel.lastUpdateString
        
        return cell
    }
}


