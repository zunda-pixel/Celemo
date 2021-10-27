//
//  AirConditioner.swift
//  AirConditioner
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct CircleButtonView: View {
    let name: String
    @State var overlayText: String = ""
    
    var body: some View {
        Image(self.name)
            .resizable()
            .padding(8)
            .frame(width: 60, height: 60)
            .imageScale(.large)
            .background(.white)
            .foregroundColor(.blue)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.5), radius: 10)
            .overlay(
                Text(self.overlayText)
            )
            .onChange(of: self.name, perform: { newValue in
                if(newValue == "auto") {
                    self.overlayText = "Auto"
                }
                else if (newValue == "quiet") {
                    self.overlayText = "静か"
                }
                else {
                    self.overlayText = ""
                }
            })
    }
    
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
            Toggle("", isOn: self.$viewModel.selectedPowerKey)
            
            ZStack {
                
                let minimum = AirConditionerRestriction.Min.rawValue
                let maximum = AirConditionerRestriction.Max.rawValue
                CircleSliderView(self.$viewModel.bindingTemperature,beginAngle: 0.1, endAngle: 0.9, minimumValue: minimum, maximumValue: maximum)
                Text("\(self.viewModel.temperature)°")
                    .font(.system(size: 60, weight: .medium, design: .default))

            }
            
            HStack {
                // モード
                Button(action: {
                    self.viewModel.selectedMode += 1
                    
                    if (self.viewModel.selectedMode >= self.viewModel.mode.count) {
                        self.viewModel.selectedMode = 0
                    }
                }, label: {
                    VStack {
                        let value = self.viewModel.mode[self.viewModel.selectedMode].value
                        CircleButtonView(name: value)
                        Text(value)
                    }
                })
                Spacer()
                // 風量
                Button(action: {
                    self.viewModel.selectedWindStrength += 1
                    
                    if (self.viewModel.selectedWindStrength >= self.viewModel.windStrength.count) {
                        self.viewModel.selectedWindStrength = 0
                    }
                }, label: {
                    VStack {
                        let value = self.viewModel.windStrength[self.viewModel.selectedWindStrength].value
                        CircleButtonView(name: value)
                        Text(value)
                    }
                })
                Spacer()
                // 風向き
                Button(action: {
                    self.viewModel.selectedDirection += 1
                    
                    if self.viewModel.selectedDirection >= self.viewModel.direction.count {
                        self.viewModel.selectedDirection = 0
                    }
                }, label: {
                    VStack {
                        Image(systemName: self.viewModel.direction[self.viewModel.selectedDirection].value)
                            .resizable()
                            .padding(15)
                            .frame(width: 60, height: 60)
                            .imageScale(.large)
                            .background(.white)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 10)
                        Text(self.viewModel.direction[self.viewModel.selectedDirection].value)
                    }
                })
            }
            
            Spacer()
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
            

            Button(action: {
                Task {
                    await viewModel.sendSignal()
                }
            }, label: {
                Text("送信")
            })
        }
        .padding(.horizontal, 30)
        .listStyle(.inset)
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
