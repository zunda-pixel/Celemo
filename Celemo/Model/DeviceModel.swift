//
//  DeviceModel.swift
//  DeviceModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

struct DeviceModel: Codable, Identifiable {
    let id: String
    let name: String
    let deviceID: String
    let apiKey: String
    
    init(name: String, deviceID: String, apiKey: String) {
        self.id = UUID().uuidString
        self.name = name
        self.deviceID = deviceID
        self.apiKey = apiKey
    }
}
