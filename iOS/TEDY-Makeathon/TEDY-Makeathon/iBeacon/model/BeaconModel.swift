//
//  BeaconModel.swift
//  TEDY-Makeathon
//
//  Created by KL on 9/9/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconModel: NSObject {
    
    let uuid: UUID
    let identifier: String
    var accuracy: CLLocationAccuracy?
    var isUnknown = true
    var lastUpdateString: String?
    
    init(uuid: UUID, identifier: String) {
        self.uuid = uuid
        self.identifier = identifier
    }
    
    func configBeaconInfo(beacon: CLBeacon, lastUpdateString: String, isUnknown: Bool) {
        self.isUnknown = isUnknown
        
        if !isUnknown {
            self.accuracy = beacon.accuracy
            self.lastUpdateString = lastUpdateString
        }
    }
}
