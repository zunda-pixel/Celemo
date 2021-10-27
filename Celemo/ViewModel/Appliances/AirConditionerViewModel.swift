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
    @Published var selectedWindStrength:Int = 1
    @Published var selectedMode: Int = 1
    @Published var selectedDirection: Int = 1
    
    let mode: KeyValuePairs = [0: "auto", 1: "cold", 2: "hot", 3: "dry", 4: "ventilator"]
    let windStrength: KeyValuePairs = [0: "auto", 1: "wind1", 2: "wind2", 3: "wind3", 4: "wind4", 5: "wind5", 6: "quiet"]
    let direction: KeyValuePairs = [0: "停止", 1: "arrow.left.arrow.right", 2: "arrow.up.arrow.down", 3: "Both"]
    
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
