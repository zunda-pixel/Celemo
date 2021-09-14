//
//  SettingsModel.swift
//  SettingsModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class SettingsModel: ObservableObject {
    @Published var registrationName : String = ""
    @Published var registrationDeviceID : String = ""
    @Published var registrationApiKey : String = ""
    
    @Published var savedDevices : [DeviceModel]
    
    init(savedDevices: [DeviceModel]) {
        self.savedDevices = savedDevices
    }
}
