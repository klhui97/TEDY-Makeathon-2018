//
//  KMBStopsInformationTableViewController.swift
//  iOS Practice
//
//  Created by david.hui on 17/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class KMBStopsInformationTableViewController: KLTableViewController {
    
    var header = ""
    var service: KMBData.Service
    
    init(service: KMBData.Service) {
        self.service = service
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for (i, _) in service.routeStops.enumerated() {
            KMBETAClient.getEtaInfo(routeStop: service.routeStops[i]) { (eta) in
                guard let eta = eta, eta.count > 0 else {
                    print("No eta data: ", self.service.routeStops[i].cName)
                    return
                }
                DispatchQueue.main.async {
                    self.service.routeStops[i].eta = eta
                    self.tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: UITableViewRowAnimation.automatic)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ETATableViewCell.self)
        header = "往 " + service.basicInfo.destinationName
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.routeStops.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ETATableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let stop = service.routeStops[indexPath.row]
        
        cell.stopNameLabel.text = stop.accessibilityName
        if let etas = service.routeStops[indexPath.row].eta {
            
            var etaString = ""
            for (i, eta) in etas.enumerated() {
                if eta.etaDisplayString == "尾班車已過本站" {
                     etaString += eta.etaDisplayString + "\n"
                }else {
                    etaString += "第\(String(i + 1))班 " + eta.etaDisplayString + "\n"
                }
            }
            cell.etaLabel.text = etaString
            cell.accessibilityHint = "如果要去坐呢班車去\(stop.cName)，請再按下"
            cell.etaLabel.textColor = .black
        }else {
            cell.etaLabel.text = "沒有數據或不經此站"
            cell.etaLabel.textColor = .red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let stop = service.routeStops[indexPath.row]
        
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(WaitingBusViewController(stop: stop), animated: true)
            return nil
        }else {
            if let oldSelectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: oldSelectedIndexPath, animated: true)
            }
            SoundHelper.shared.speak(stop.accessibilityName + " 如果要搭呢班車請再按一下")
        }
        
        return indexPath
    }
}
