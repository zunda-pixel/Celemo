//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var settingsModel: SettingsModel = SettingsModel(name: "", deviceID: "", apiKey: "")
    @Published var happenedError : Bool = false
    
    var errorMessage = ""
    
    public func registerDevice() {
        let newDevice = DeviceModel(name: settingsModel.name, deviceID: settingsModel.deviceID, apiKey: settingsModel.apiKey)
        
        let isValid = self.isValidDevice(newDevice)
        
        if !isValid {
            return
        }
        
        self.settingsModel.devices.append(newDevice)
        self.saveDevices()
        self.clearRegistrationData()
    }
    
    public func isValidDevice(_ deviceModel: DeviceModel) -> Bool {
        if deviceModel.name == "" {
            self.errorMessage = "デバイス名が空です。"
            self.happenedError.toggle()
            return false
        }
        
        if deviceModel.deviceID == "" {
            self.errorMessage = "デバイスIDが空です。"
            self.happenedError.toggle()
            return false
        }
        
        if deviceModel.apiKey == "" {
            self.errorMessage = "APIキーが空です。"
            self.happenedError.toggle()
            return false
        }
        
        return true
    }
    
    public func removeDeviceModelAt(offsets: IndexSet) {
        self.settingsModel.devices.remove(atOffsets: offsets)
        self.saveDevices()
    }
    
    public func saveDevices() {
        do {
            try UserDefaultWrapper.saveArrayOfData(key: "devicesData", self.settingsModel.devices)
        } catch {
            self.happenedError.toggle()
            self.errorMessage = "保存に失敗しました。"
        }
    }
    
    public func loadDevices() {
        do {
            let devices: [DeviceModel] = try UserDefaultWrapper.loadArrayOfData(key: "devicesData")
            settingsModel.devices = devices
        } catch {
            self.happenedError.toggle()
            self.errorMessage = "保存データのロードに問題がありました。"
        }
    }
    
    private func clearRegistrationData() {
        self.settingsModel.name = ""
        self.settingsModel.deviceID = ""
        self.settingsModel.apiKey = ""
    }
}
