//
//  AirConditioner.swift
//  AirConditioner
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

enum AirConditionerRestriction: Double {
    case Min = 16
    case Max = 31
}




struct AirConditionerView: View {
    @StateObject var viewModel: AirConditionerViewModel = AirConditionerViewModel()
    
    let device: DeviceModel
    let appliancesNumber: Int
    
    init(device:DeviceModel, appliancesNumber: Int) {
        self.device = device
        self.appliancesNumber = appliancesNumber
    }
    
    var body: some View {
        VStack {
            Section(content: {
                Picker(selection: $viewModel.selectedPowerKey, label: Text("電源を選択")) {
                    ForEach([String](Signal.AirConditioner.Power.keys), id: \String.hashValue) { key in
                        Text(String(describing: key))
                            .tag(key)
                    }
                }
                .pickerStyle(.segmented)
            }, header: {
                Text("電源")
            })
            
            
            Section (content: {
                let keys = Signal.AirConditioner.Mode.map{$0.key}
                Picker(selection: $viewModel.selectedModeKey, label: Text("モードを選択")) {
                    ForEach(keys.indices) { index in
                        Text(keys[index])
                            .tag(keys[index])
                    }
                }
                .pickerStyle(.segmented)
            }, header: {
                Text("モード")
            })

            Section(content: {
                let keys = Signal.AirConditioner.AirFlowAmount.map{$0.key}
                Picker(selection: $viewModel.selectedAirFlowAmountKey, label: Text("風量を選択")) {
                    ForEach(keys.indices) { index in
                        Text(keys[index])
                            .tag(keys[index])
                    }
                }
                .pickerStyle(.segmented)
            }, header: {
                Text("風量")
            })

            Section(content: {
                let keys = Signal.AirConditioner.AirFlowDirection.map{$0.key}
                
                Picker(selection: $viewModel.selectedAirFlowDirectionKey, label: Text("風向きを選択")) {
                    ForEach(keys.indices) { index in
                        Text(keys[index])
                            .tag(keys[index])
                    }
                }
                .pickerStyle(.segmented)
            }, header: {
                Text("風向き")
            })
            
            ZStack {
                Text("\(self.viewModel.temperature)")
                
                let minimum = AirConditionerRestriction.Min.rawValue
                let maximum = AirConditionerRestriction.Max.rawValue
                CircleSliderView(self.$viewModel.bindingTemperature,beginAngle: 0.1, endAngle: 0.9, minimumValue: minimum, maximumValue: maximum)
            }
            .padding(.vertical, 30)
            
            Button(action: {
                Task {
                    await viewModel.sendSignal()
                }
            }, label: {
                Text("送信")
            })
        }
        .padding(.horizontal, 30)
        .listStyle(InsetListStyle())
        .onAppear(perform: {
            self.viewModel.device = self.device
            self.viewModel.appliancesNumber = self.appliancesNumber
        })
    }
}

struct AirConditioner_Previews: PreviewProvider {
    static var previews: some View {
        AirConditionerView(device: DeviceModel(name: "test", deviceID: "test", apiKey: "test"), appliancesNumber: 0)
    }
}
