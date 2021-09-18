//
//  DeviceModel.swift
//  DeviceModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class DeviceModel: NSObject, Identifiable, NSSecureCoding {
    let id = UUID()
    let name: String
    let deviceID: String
    let apiKey: String
    
    init(name: String, deviceID: String, apiKey: String) {
        self.name = name
        self.deviceID = deviceID
        self.apiKey = apiKey
    }
    
    required init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: "name") as? String,
              let deviceID = coder.decodeObject(forKey: "deviceID") as? String,
              let apiKey = coder.decodeObject(forKey: "apiKey") as? String else {
            return nil
        }
        
        self.name = name
        self.deviceID = deviceID
        self.apiKey = apiKey
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(deviceID, forKey: "deviceID")
        coder.encode(apiKey, forKey: "apiKey")
    }
    
    static var supportsSecureCoding: Bool {
        return true
    }
}
