//
//  DeviceModel.swift
//  DeviceModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

struct DeviceModel: Identifiable {
    let id = UUID()
    let name: String
    let deviceID: String
    let apiKey: String
}
