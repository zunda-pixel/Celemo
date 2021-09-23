//
//  AirConditionerViewModel.swift
//  AirConditionerViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class AirConditionerViewModel: ObservableObject {
    var device: DeviceModel? = nil
    var appliancesNumber: Int? = nil
    
    @Published var selectedTemperature:Int = 27
    @Published var selectedPowerKey: String = "電源オン"
    @Published var selectedModeKey: String = "自動"
    @Published var selectedAirFlowAmountKey: String = "自動"
    @Published var selectedAirFlowDirectionKey: String = "両方"
    
    public func sendSignal() async {
        guard let powerValue = AirConditionerSignal.Power[selectedPowerKey],
              let modeValue = AirConditionerSignal.Mode[selectedModeKey],
              let airFlowAmountValue = AirConditionerSignal.AirFlowAmount[selectedAirFlowAmountKey],
              let airFlowDirectionValue = AirConditionerSignal.AirFlowDirection[selectedAirFlowDirectionKey],
              let appliancesNumber = appliancesNumber else {
            return
        }
        
        let signal = "\(appliancesNumber)-a-\(powerValue)-\(modeValue)-\(airFlowAmountValue)-\(airFlowDirectionValue)-\(selectedTemperature)"
        
        print(signal)
        
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
