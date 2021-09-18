//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var settingsModel: SettingsModel = SettingsModel()
    @Published var happenedError : Bool = false
    var errorMessage = ""
    
    public func registerDevice() {
        let newDeviceModel = DeviceModel(name: settingsModel.registrationName, deviceID: settingsModel.registrationDeviceID, apiKey: settingsModel.registrationApiKey)
        let isValid = self.isValidDevice(newDeviceModel)
        
        if !isValid {
            return
        }
        
        self.settingsModel.savedDevices.append(newDeviceModel)        
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
        self.settingsModel.savedDevices.remove(atOffsets: offsets)
        self.saveDevices()
    }
    
    public func saveDevices() {
        let result = UserDefaultWrapper.saveArrayOfData(key: "devicesData", self.settingsModel.savedDevices)
        switch result {
            case .LoadError:
                self.happenedError.toggle()
                self.errorMessage = "保存に失敗しました。"
            case .NotFoundKey:
                self.happenedError.toggle()
                self.errorMessage = "保存に失敗しました。"
            case .SaveError:
                self.happenedError.toggle()
                self.errorMessage = "保存に失敗しました。"
            case .NoError:
                break
        }
    }
    
    public func loadDevices() {
        let result: Result<[DeviceModel], SavingError> = UserDefaultWrapper.loadArrayOfData(key: "devicesData")
        switch result {
            case .success(let deviceModels):
                self.settingsModel.savedDevices = deviceModels
            case .failure(let error):
                switch error {
                    case .NoError:
                        break
                    case .LoadError:
                        self.happenedError.toggle()
                        self.errorMessage = "保存データのロードに問題がありました。"
                    case .NotFoundKey:
                        happenedError.toggle()
                        self.errorMessage = "保存データのロードに問題がありました。"
                    case .SaveError:
                        self.happenedError.toggle()
                        self.errorMessage = "保存データのロードに問題がありました。"
                }
        }
    }
    
    private func clearRegistrationData() {
        self.settingsModel.registrationName = ""
        self.settingsModel.registrationDeviceID = ""
        self.settingsModel.registrationApiKey = ""
    }
}
