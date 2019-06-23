//
//  EncryptedDeviceKitTests.swift
//  EncryptedDeviceKitTests
//
//  Created by Arunprasat Selvaraj on 23/06/2019.
//  Copyright © 2019 Arunprasat Selvaraj. All rights reserved.
//

import XCTest
@testable import EncryptedDeviceKit

class EncryptedDeviceKitTests: XCTestCase {
    
    var device: EncryptedDeviceInfo!
    
    override func setUp() {
        
        do {
            device = try EncryptedDeviceInfo.init(key: "8C182623CD047A0D6593691B2179B98440A91AF01E4BB2BD90D49CC9E9D171E7".data(using: .utf8) ?? Data(), iv: "8DB023E39C39B95EBC0155DA9F14C37D".data(using: .utf8) ?? Data())
        }
        catch {
            print(error)
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        device = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEncryptionandDecryptionforValidValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        device.getEncryptedCurrentDeviceData(completionBlock: { (data) in
            
            device.getDecryptedCurrentDeviceData(encrptedData: data, completionBlock: { (data) in
                
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    XCTAssertNotNil(dict, "The value should not be nil")
                    XCTAssertNotNil(dict?["systemName"], "The systemName should not be nil")
                    XCTAssertNotNil(dict?["name"], "The name should not be nil")
                    XCTAssertNotNil(dict?["model"], "The model should not be nil")

                }
                catch {
                    print(error)
                }
            }, errorBlock: { (error) in
                print(error)
            })
        }) { (error) in
            
            print(error)
        }
    }
    
    func testEncryptionandDecryptionforInValidKey() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do {
            device = try EncryptedDeviceInfo.init(key: "dafqwefgrth".data(using: .utf8) ?? Data(), iv: "8DB023E39C39B95EBC0155DA9F14C37D".data(using: .utf8) ?? Data())
        }
        catch {
            XCTAssertEqual(error.localizedDescription, "badKeyLength", "")
            print(error)
        }
        
        device.getEncryptedCurrentDeviceData(completionBlock: { (data) in
            
        }) { (error) in

            XCTAssertNotNil(error, "error should not be nil")
        }
    }
    
    func testDecryptionforInValidInput() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do {
            device = try EncryptedDeviceInfo.init(key: "8C182623CD047A0D6593691B2179B98440A91AF01E4BB2BD90D49CC9E9D171E7".data(using: .utf8) ?? Data(), iv: "8DB023E39C39B95EBC0155DA9F14C37D".data(using: .utf8) ?? Data())
        }
        catch {
            print(error)
        }
        
        device.getDecryptedCurrentDeviceData(encrptedData: Data(), completionBlock: { (data) in
           
        }, errorBlock: { (error) in
            XCTAssertNotNil(error, "error should not be nil")
        })
    }
    
    func testDecriptionforInValidValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do {
            device = try EncryptedDeviceInfo.init(key: "8C182623CD047A4D6593691B2179B98440A91AF01E4BB2BD90D49CC9E9D171E7".data(using: .utf8) ?? Data(), iv: "14C37D8DB023E39C39B95EBC0155DA9F".data(using: .utf8) ?? Data())
        }
        catch {
            print(error)
        }
        
        device.getEncryptedCurrentDeviceData(completionBlock: { (data) in
            
            device.getDecryptedCurrentDeviceData(encrptedData: data, completionBlock: { (data) in
                
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                }
                catch {
                    
                    XCTAssertNotNil(error, "error should not be nil")
                }
            }, errorBlock: { (error) in
                print(error)
            })
        }) { (error) in
            
            print(error)
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
