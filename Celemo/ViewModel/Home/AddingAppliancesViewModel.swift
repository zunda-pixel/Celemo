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
        do {
            let devices: [DeviceModel] = try UserDefaults.loadArrayOfData(key: .DevicesData)
            self.devices.append(contentsOf: devices)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
