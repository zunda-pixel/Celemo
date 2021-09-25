//
//  DeviceModel.swift
//  DeviceModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class DeviceModel: NSObject, Identifiable, NSSecureCoding {
    let id: String
    let name: String
    let deviceID: String
    let apiKey: String
    
    static var supportsSecureCoding: Bool = true

    init(name: String, deviceID: String, apiKey: String) {
        self.id = "\(UUID())"
        self.name = name
        self.deviceID = deviceID
        self.apiKey = apiKey
    }
    
    required init?(coder: NSCoder) {
        guard let id = coder.decodeObject(forKey: "id") as? String,
              let name = coder.decodeObject(forKey: "name") as? String,
              let deviceID = coder.decodeObject(forKey: "deviceID") as? String,
              let apiKey = coder.decodeObject(forKey: "apiKey") as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.deviceID = deviceID
        self.apiKey = apiKey
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.deviceID, forKey: "deviceID")
        coder.encode(self.apiKey, forKey: "apiKey")
    }

}
