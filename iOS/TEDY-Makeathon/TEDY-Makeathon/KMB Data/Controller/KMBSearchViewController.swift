//
//  KMBSearchViewController.swift
//  iOS Practice
//
//  Created by david.hui on 14/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import AVFoundation

class KMBSearchViewController: KLTableViewController, UISearchBarDelegate {
    
    var header = ""
    let searchController = UISearchController(searchResultsController: nil)
    var targetRouteData: KMBData? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header = "路線搜尋"
        tableView.rowHeight = 100
        
        // Load the shared data first
        print(KMBDataManager.shared.getKmbData)
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true) {
            self.targetRouteData = KMBDataManager.shared.getKmbData(route: searchBar.text ?? "")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let targetRouteData = targetRouteData {
            return targetRouteData.services.count
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return targetRouteData?.route ?? header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular)
        
        if let service = targetRouteData?.services[indexPath.row] {
            if service.serviceType == "1" {
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = """
                路線\(service.bound):  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)
                """
            }else {
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = """
                ＊特別線:  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)
                """
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard let service = targetRouteData?.services[indexPath.row] else {
            return nil
        }
        
        if tableView.indexPathForSelectedRow == indexPath {
            navigationController?.pushViewController(KMBStopsInformationTableViewController(service: service), animated: true)
        }else {
            if let oldSelectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: oldSelectedIndexPath, animated: true)
            }
            if service.serviceType == "1" {
                SoundHelper.shared.speak("路線\(service.bound):  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)" + "如果要搭呢條路線請再按下")
            }else {
                SoundHelper.shared.speak("特別線:  由 \(service.basicInfo.originName) 出發至 \(service.basicInfo.destinationName)" + "如果要搭呢條路線請再按下")
            }
            
            return indexPath
        }
        
        
        return nil
    }
}
