//
//  AirConditionerViewModel.swift
//  AirConditionerViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation
import Collections

class AirConditionerViewModel: ObservableObject {
    @Published var bindingTemperature: Double = 25
    @Published var selectedPowerKey: Bool = true
    @Published var selectedWindStrength:Int = 0
    @Published var selectedMode: Int = 0
    @Published var selectedDirection: Int = 0
    
    let mode: OrderedSet = ["auto", "cold", "hot", "dry", "ventilator"]
    let windStrength: OrderedSet = ["auto", "wind1", "wind2", "wind3", "wind4", "wind5", "quiet"]
    let direction: OrderedSet = ["stop", "arrow.left.arrow.right", "arrow.up.arrow.down", "both"]
    
    var device: DeviceModel? = nil
    
    var appliancesNumber: Int? = nil
    
    var temperature: Int {
        return Int(self.bindingTemperature)
    }
    
    public func sendSignal() async {
        guard let powerValue = Signal.AirConditioner.Power[selectedPowerKey],
              let appliancesNumber = appliancesNumber else {
              return
        }
        
        let signal = "\(appliancesNumber)-a-\(powerValue)-\(self.selectedMode + 1)-\(self.selectedWindStrength + 1)-\(self.selectedDirection)-\(temperature)"

        guard let apiKey = device?.apiKey,
              let deviceID = device?.deviceID else {
            return
        }

        do {
            try await sRemoAPIClient.sendSignal(signal: signal, apiKey: apiKey, deviceID: deviceID)
        } catch let error {
            print(error)
        }
    }
}
