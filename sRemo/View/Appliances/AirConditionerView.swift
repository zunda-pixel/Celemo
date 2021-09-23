//
//  AirConditioner.swift
//  AirConditioner
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct AirConditionerSignal {
    static let Power = [
        "電源オン" : "n",
        "電源オフ" : "f"
    ]
    
    static let Mode = [
        "自動" : 1,
        "冷房" : 2,
        "暖房" : 3,
        "ドライ" : 4,
        "送風" : 5,
    ]

    static let AirFlowAmount = [
        "自動" : 1,
        "強さ1" : 2,
        "強さ2" : 3,
        "強さ3" : 4,
        "強さ4" : 5,
        "強さ5" : 6,
        "静か" : 7,
    ]

    static let AirFlowDirection = [
        "停止" : 1,
        "上下" : 2,
        "左右" : 3,
        "両方" : 4,
    ]
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
        List {
            Section(content: {
                Picker(selection: $viewModel.selectedPowerKey, label: Text("電源を選択")) {
                    ForEach([String](AirConditionerSignal.Power.keys), id: \String.hashValue) { key in
                        Text(String(describing: key))
                            .tag(key)
                    }
                }
                .pickerStyle(.segmented)
            }, header: {
                Text("電源")
            })
            
            
            Section (content: {
                let keys = AirConditionerSignal.Mode.map{$0.key}
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
                let keys = AirConditionerSignal.AirFlowAmount.map{$0.key}
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
                let keys = AirConditionerSignal.AirFlowDirection.map{$0.key}
                
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

            Section(content: {
                TextField("温度", value: $viewModel.selectedTemperature, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }, header: {
                Text("温度")
            })
            
            Button(action: {
                Task {
                    await viewModel.sendSignal()
                }
            }, label: {
                Text("送信")
            })
        }
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
