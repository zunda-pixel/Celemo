//
//  AirConditionerViewModel.swift
//  AirConditionerViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class AirConditionerViewModel: ObservableObject {
    @Published var bindingTemperature: Double = 25
    @Published var selectedPowerKey: Bool = true
    @Published var selectedModeKey: String = "自動"
    @Published var selectedAirFlowAmountKey: String = "自動"
    @Published var selectedAirFlowDirectionKey: String = "両方"
    
    var device: DeviceModel? = nil
    
    var appliancesNumber: Int? = nil
    
    var temperature: Int {
        return Int(self.bindingTemperature)
    }
    
    public func sendSignal() async {
        guard let powerValue = Signal.AirConditioner.Power[selectedPowerKey],
              let appliancesNumber = appliancesNumber,
              let modeValue = Signal.AirConditioner.Mode.first(where: { $0.key == self.selectedModeKey})?.value,
              let airFlowAmountValue = Signal.AirConditioner.AirFlowAmount.first(where: {$0.key == self.selectedAirFlowAmountKey})?.value,
              let airFlowDirectionValue = Signal.AirConditioner.AirFlowDirection.first(where: {$0.key == self.selectedAirFlowDirectionKey})?.value else {
          return
      }
        
        let signal = "\(appliancesNumber)-a-\(powerValue)-\(modeValue)-\(airFlowAmountValue)-\(airFlowDirectionValue)-\(temperature)"
                
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
