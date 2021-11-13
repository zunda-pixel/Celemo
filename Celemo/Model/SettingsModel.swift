//
//  SettingsModel.swift
//  SettingsModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

struct SettingsModel {
    var name: String
    var id: String
    var apiKey: String
    
    var devices : [DeviceModel] = []
}
