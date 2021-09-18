//
//  SettingsModel.swift
//  SettingsModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

struct SettingsModel {
    var registrationName : String = ""
    var registrationDeviceID : String = ""
    var registrationApiKey : String = ""
    var savedDevices : [DeviceModel] = []
}
