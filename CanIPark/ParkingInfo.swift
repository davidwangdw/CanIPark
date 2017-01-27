//
//  ParkingInfo.swift
//  CanIPark
//
//  Created by David Wang on 1/19/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import Foundation

class ParkingInfo{
    
    lazy var streetCode = String()
    lazy var parkingInfoSignArray = [ParkingInfoSign]()
    lazy var latitudeStart = Double()
    lazy var latitudeEnd = Double()
    lazy var longitudeStart = Double()
    lazy var longitudeEnd = Double()
    
    init() {
        
    }
    
    init(newStreetCode: String) {
        streetCode = newStreetCode
    }
    
    init(newStreetCode: String, newLatitudeStart: Double, newLatitudeEnd: Double, newLongitudeStart: Double, newLongitudeEnd: Double) {
        streetCode = newStreetCode
        latitudeStart = newLatitudeStart
        latitudeEnd = newLatitudeEnd
        longitudeStart = newLongitudeStart
        longitudeEnd = newLongitudeEnd
    }
    
    func addSignInfo(signInfo: ParkingInfoSign) {
        parkingInfoSignArray.append(signInfo)
    }
    
    func printSignInfo() {
        for item in parkingInfoSignArray {
            print(item.returnSignDescription())
        }
    }
    
    func returnStreetCode() -> String {
        return streetCode
    }
}

class ParkingInfoSign{
    
    lazy var latitude = Double()
    lazy var longitude = Double()
    
    lazy var streetCode = String()
    
    lazy var signDescription = String()
    
    init() {
        
    }
    
    init(newLatitude: Double, newLongitude: Double, newStreetCode: String, newSignDescription: String) {
        
        latitude = newLatitude
        longitude = newLongitude
        streetCode = newStreetCode
        signDescription = newSignDescription
        
    }
    
    func returnSignDescription() -> String {
        return signDescription
    }
}
