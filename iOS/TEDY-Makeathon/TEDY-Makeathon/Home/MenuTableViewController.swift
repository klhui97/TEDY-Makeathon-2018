//
//  HomeTableViewController.swift
//  iOS Practice
//
//  Created by KL on 6/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

protocol MenuTableViewControllerDelegate {
    func changeViewController(toController: UIViewController)
}

private extension MenuTableViewController {
    
    func getController(_ rowType: Row) -> UIViewController {
        
        switch rowType {
        case .iBeacon:
            return iBeaconViewController()
        case .kmb:
            return KMBSearchViewController()
        case .speech:
            return SpeechRecognitionViewController()
        case .bt:
            return BluetoothReadWriteViewController()
        }
    }
}

class MenuTableViewController: KLTableViewController {
    
    // MARK: - Practice data
    enum Row: String {
        case iBeacon = "iBeacon"
        case kmb = "KMB"
        case speech = "Speech"
        case bt = "Bluetooth"
    }
    
    var rows: [Row] = [.iBeacon, .kmb, .speech, .bt]
    var delegate: MenuTableViewControllerDelegate?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.register(LargeTitleTableViewCell.self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return rows.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: LargeTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.largeTitleLabel.text = "Demo"
            return cell
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = rows[indexPath.row].rawValue
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            delegate?.changeViewController(toController: getController(rows[indexPath.row]))
        }
    }
}
