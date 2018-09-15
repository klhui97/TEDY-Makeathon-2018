//
//  KMBData.swift
//  iOS Practice
//
//  Created by KL on 15/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Foundation

struct KMBData: Codable {
    var route: String
    var services: [Service]
    
    enum CodingKeys: String, CodingKey {
        case route = "Route"
        case services = "Services"
    }
    
    struct Service: Codable {
        var serviceType: String
        var bound: String
        var route: String
        var basicInfo: BasicInfo
        var routeStops: [RouteStop]
        
        enum CodingKeys: String, CodingKey {
            case serviceType = "SERVICE_TYPE"
            case bound = "BOUND"
            case route = "ROUTE"
            case basicInfo = "BASIC_INFO"
            case routeStops = "ROUTE_STOPS"
        }
    }
    
    struct BasicInfo: Codable {
        var originName: String
        var destinationName: String
        
        enum CodingKeys: String, CodingKey {
            case originName = "OriCName"
            case destinationName = "DestCName"
        }
    }
    
    struct RouteStop: Codable {
        var cName: String
        var serviceType: String
        var bound: String
        var route: String
        var bsiCode: String
        var stopSeq: String
        var eta: [KMBETAClient.EtaData]?
        
        var accessibilityName: String {
            return "往: " + cName
        }
        
        var accessibilityArraivalString: String {
            if let eta = eta, eta.count > 0 {
                if let tips = eta[0].remindingArrivalTime {
                    return accessibilityName + " 最快既到站時間係" + tips
                }else {
                    return accessibilityName + " 既車即將到達或已經離開"
                }
            }else {
                return " 沒有第一班車到達時間數據"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case cName = "CName"
            case serviceType = "ServiceType"
            case bound = "Bound"
            case route = "Route"
            case stopSeq = "Seq"
            case bsiCode = "BSICode"
        }
    }
}
