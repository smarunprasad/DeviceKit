//
//  DeviceInfo.swift
//  DeviceKit
//
//  Created by Arunprasat Selvaraj on 23/06/2019.
//  Copyright © 2019 Arunprasat Selvaraj. All rights reserved.
//

import Foundation
import UIKit


public struct Device {
    
    public var name: String?
    public var model: String?
    public var localizedModel: String?
    public var systemName: String?
    public var systemVersion: String?
    public var batteryLevel: String?
    public var isBatteryMonitoringEnabled: Bool?
    public var isProximityMonitoringEnabled: Bool?
    public var isMultitaskingSupported: Bool?
   
    init(name: String, model: String, localizedModel: String, systemName: String, systemVersion: String, batteryLevel: Float, isBatteryMonitoringEnabled: Bool, isProximityMonitoringEnabled: Bool, isMultitaskingSupported: Bool) {
        
        self.name =  name
        self.model = model
        self.localizedModel = localizedModel
        self.systemName = systemName
        self.systemVersion = systemName
        self.batteryLevel = String(batteryLevel)
        self.isBatteryMonitoringEnabled =  isBatteryMonitoringEnabled
        self.isProximityMonitoringEnabled = isProximityMonitoringEnabled
        self.isMultitaskingSupported = isMultitaskingSupported
    }
}

public class DeviceInfo {

    public init() {
        
    }
    //To get the current device Info
    public func getDeviceInfo(completionHandler: (Device) -> Void) {
        
        let device  = UIDevice.current
        
        let deviceModel = Device.init(name: device.name, model: device.model, localizedModel: device.localizedModel, systemName: device.systemName, systemVersion: device.systemVersion, batteryLevel: device.batteryLevel, isBatteryMonitoringEnabled: device.isBatteryMonitoringEnabled, isProximityMonitoringEnabled: device.isProximityMonitoringEnabled, isMultitaskingSupported: device.isMultitaskingSupported)
        
        completionHandler(deviceModel)
    }
}
