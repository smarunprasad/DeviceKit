//
//  EncryptedDeviceInfo.swift
//  EncryptedDeviceKit
//
//  Created by Arunprasat Selvaraj on 23/06/2019.
//  Copyright © 2019 Arunprasat Selvaraj. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
import Security


public class EncryptedDeviceInfo {
    
    //Constants
    let name = "name"
    let model = "model"
    let localizedModel = "localizedModel"
    let systemName = "systemName"
    let systemVersion = "systemVersion"
    let batteryLevel = "batteryLevel"
    let proximityState = "proximityState"
    
    let isBatteryMonitoringEnabled = "isBatteryMonitoringEnabled"
    let isProximityMonitoringEnabled = "isProximityMonitoringEnabled"
    let isMultitaskingSupported = "isMultitaskingSupported"
    
    //Variables
    private var key: Data
    private var inputVector: Data
    
    //Init
    public init(key: Data, iv: Data) throws {
        guard !(key.isEmpty) else {
            throw Error.badKeyLength
        }
        guard !(iv.isEmpty) else {
            throw Error.badInputVectorLength(iv: iv)
        }
        self.key = key
        self.inputVector = iv
    }
    
    
    public enum Error: Swift.Error {
        case keyGeneration(status: Int)
        case encryptFailed
        case badKeyLength
        case badInputVectorLength(iv: Data)
    }
}

extension EncryptedDeviceInfo {
    
    //To get the current device Info
    func getDeviceInfo() -> Data {
        
        let device  = UIDevice.current
        
        var deviceInfo = [String: Any]()
        
        deviceInfo[name] = device.name
        deviceInfo[model] = device.model
        deviceInfo[localizedModel] = device.localizedModel
        deviceInfo[systemName] = device.systemName
        deviceInfo[systemVersion] = device.systemVersion
        deviceInfo[isBatteryMonitoringEnabled] = device.isBatteryMonitoringEnabled
        deviceInfo[batteryLevel] = device.batteryLevel
        deviceInfo[isProximityMonitoringEnabled] = device.isProximityMonitoringEnabled
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: deviceInfo, options: [])
            return jsonData
        } catch {
            return Data()
        }
    }
}

