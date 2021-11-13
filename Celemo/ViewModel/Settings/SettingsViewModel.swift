//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var settingsModel: SettingsModel = SettingsModel(name: "", id: "", apiKey: "")
    @Published var happenedError : Bool = false
    
    var errorMessage = ""
    
    public func registerDevice() {
        let newDevice = DeviceModel(name: settingsModel.name, deviceID: settingsModel.id, apiKey: settingsModel.apiKey)
        
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
            //self.happenedError.toggle()
            return false
        }
        
        if deviceModel.deviceID == "" {
            self.errorMessage = "デバイスIDが空です。"
            //self.happenedError.toggle()
            return false
        }
        
        if deviceModel.apiKey == "" {
            self.errorMessage = "APIキーが空です。"
            //self.happenedError.toggle()
            return false
        }

        let foundSameNameDevice = settingsModel.devices.contains(where: { return $0.name == settingsModel.name })
        
        if foundSameNameDevice {
            self.errorMessage = "同じデバイス名が既に存在します。"
            //self.happenedError.toggle()
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
            try UserDefaults.saveArrayOfData(key: .DevicesData, self.settingsModel.devices)
        } catch {
            //self.happenedError.toggle()
            self.errorMessage = "保存に失敗しました。"
        }
    }
    
    public func loadDevices() {
        do {
            let devices: [DeviceModel] = try UserDefaults.loadArrayOfData(key: .DevicesData)
            settingsModel.devices = devices
        } catch {
            //self.happenedError.toggle()
            self.errorMessage = "保存データのロードに問題がありました。"
        }
    }
    
    private func clearRegistrationData() {
        self.settingsModel.name = ""
        self.settingsModel.id = ""
        self.settingsModel.apiKey = ""
    }
}
