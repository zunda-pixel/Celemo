//
//  AddingAppliancesViewModel.swift
//  Celemo
//
//  Created by zunda on 2021/09/20.
//

import Foundation

class AddingAppliancesViewModel: ObservableObject {
    @Published var devices: [DeviceModel] = []
    
    init() {
        self.loadDevices()
    }
    
    func loadDevices() {
        if let devices : [DeviceModel] = try? UserDefaultWrapper.loadArrayOfData(key: "devicesData") {
            self.devices.append(contentsOf: devices)
        }
    }
}
