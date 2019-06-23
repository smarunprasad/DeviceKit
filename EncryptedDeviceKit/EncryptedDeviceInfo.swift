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

public protocol Encrypter {
    
    func encryptedDeviceInfo() throws -> Data
    func decrypt(_ encrypted: Data) throws -> Data
}


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
    
    //To get the device data in encryped type
    //Call this methode in your class it will return the device in the encripted formate
    //To decrypt pass the encrypted value to the EncryptedDeviceKit with Key & inputVector values which is used for the encrytion.
    open func getEncryptedCurrentDeviceData(completionBlock: (Data) -> Void, errorBlock: (Error) -> Void) {
        
        do {
            //It returns the device data in encrypted formate.
            let encrptedData = try self.encryptedDeviceInfo()
            completionBlock(encrptedData)
        } catch  {
            errorBlock(Error.encryptFailed)
        }
    }
    
    open func getDecryptedCurrentDeviceData(encrptedData:Data, completionBlock: (Data) -> Void, errorBlock: (Error) -> Void) {
        
        do {
            //It returns the decrypted data for the given encrptedData
            let decrptedData = try self.decrypt(encrptedData)
            completionBlock(decrptedData)
        } catch  {
            errorBlock(Error.encryptFailed)
        }
    }
    
    
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
    
    // Used to encrypt or decrypt the data based on the key & inputVector values
    // This will called for the Encrypt protocal function for encrypt or decrypt
    private func crypt(input: Data, operation: CCOperation) throws -> Data {
        
        let outputLength = input.count + kCCBlockSizeAES128
        var outputBuffer = Array<UInt8>(repeating: 0,
                                        count: outputLength)
        var numBytesEncrypted = 0
        
        let status = CCCrypt(CCOperation(kCCEncrypt), // operation
            CCAlgorithm(kCCAlgorithmAES),   // algorithm
            CCOptions(kCCOptionPKCS7Padding), // options
            Array(key),  // key
            kCCKeySizeAES256, // keylength
            Array(inputVector), // iv
            Array(input), // dataIn
            input.count, // dataInLength
            &outputBuffer, // dataOut
            outputLength, // dataOutLength
            &numBytesEncrypted) // dataOutMoved
        
        guard status == kCCSuccess else {
            throw Error.encryptFailed
        }
        
        let outputBytes = outputBuffer.prefix(numBytesEncrypted)
        return Data(outputBytes)
    }
}


extension EncryptedDeviceInfo: Encrypter {
    
    open func encryptedDeviceInfo() throws -> Data {
        
        return try crypt(input: self.getDeviceInfo(), operation: CCOperation(kCCEncrypt))
    }
    
    open func decrypt(_ encrypted: Data) throws -> Data {
        
        return try crypt(input: encrypted, operation: CCOperation(kCCDecrypt))
    }
}
