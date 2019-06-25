//
//  DeviceKitTests.swift
//  DeviceKitTests
//
//  Created by Arunprasat Selvaraj on 23/06/2019.
//  Copyright © 2019 Arunprasat Selvaraj. All rights reserved.
//

import XCTest
@testable import DeviceKit

class DeviceKitTests: XCTestCase {
    
    var device = DeviceInfo()
    
    override func setUp() {
        
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        device = DeviceInfo()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDeviceInfoMethodeForValidValues() {
        
    
        device.getDeviceInfo { (device) in
            
            XCTAssertNotNil(device, "device should not be nil")
            XCTAssertNotNil(device.name, "name should not be nil")
            XCTAssertNotNil(device.model, "model should not be nil")
            XCTAssertNotNil(device.systemName, "system name should not be nil")
            XCTAssertNotNil(device.systemVersion, "system version name should not be nil")
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
