//
//  BeaconManager.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import CoreLocation

protocol BeaconManagerDelegate {
    func didUpdateBeacon(for index: Int)
}

class BeaconManager: NSObject {
    
    let locationManager = CLLocationManager()
    var targetBeacons: [BeaconModel] = []
    var delegate: BeaconManagerDelegate?
    
    override init() {
        super.init()
        print("BeaconManager inited")
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    deinit {
        print("BeaconManager deinited")
    }
    
    func monitorAllTargetBeacons() {
        for beacon in targetBeacons {
            searchForBeacon(beacon: beacon)
        }
    }
    
    private func searchForBeacon(beacon: BeaconModel) {
        let region = CLBeaconRegion(proximityUUID: beacon.uuid, identifier: beacon.identifier)
        
        locationManager.startRangingBeacons(in: region)
        locationManager.startMonitoring(for: region)
    }

}

// MARK: - CLLocationManagerDelegate

extension BeaconManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            handleBeaconInfo(beacon)
        }
    }
    
    func handleBeaconInfo(_ beacon: CLBeacon) {
        if let targetIndex = targetBeacons.index(where: { $0.uuid ==  beacon.proximityUUID} ) {
            let lastUpdateString = DateHelper.currentTimeString()
            
            switch beacon.proximity {
            case .unknown:
                targetBeacons[targetIndex].configBeaconInfo(beacon: beacon, lastUpdateString: lastUpdateString, isUnknown: true)
            default:
                targetBeacons[targetIndex].configBeaconInfo(beacon: beacon, lastUpdateString: lastUpdateString, isUnknown: false)
            }
            
            delegate?.didUpdateBeacon(for: targetIndex)
            print(targetBeacons[targetIndex].identifier, "accury=\(beacon.accuracy) rssi=\(beacon.rssi) major=\(beacon.major) minor\(beacon.minor)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit \(region.identifier)")
    }
}
