//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation
import SwiftUI


class SettingsViewModel: ObservableObject {
    @Published var settingsModel: SettingsModel
    
    public init() {
        let savedDevices = [DeviceModel(name: "", deviceID: "", apiKey: "")]
        settingsModel = SettingsModel(savedDevices: savedDevices)
    }
    
    public func registerDevice() {
        let newDeviceModel = DeviceModel(name: settingsModel.registrationName, deviceID: settingsModel.registrationApiKey, apiKey: settingsModel.registrationDeviceID)
        self.settingsModel.savedDevices.append(newDeviceModel)
        
        self.clearRegistrationData()
    }
    
    public func saveRegisteredDevices() {
        
    }
    
    public func loadRegisteredDevices() {
        
    }
    
    private func clearRegistrationData() {
        self.settingsModel.registrationName = ""
        self.settingsModel.registrationDeviceID = ""
        self.settingsModel.registrationApiKey = ""
    }
}
