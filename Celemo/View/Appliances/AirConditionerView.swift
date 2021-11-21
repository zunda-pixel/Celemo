//
//  AirConditioner.swift
//  AirConditioner
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct CircleButtonView: View {
    let name: String
    
    var body: some View {
        Image(self.name)
            .resizable()
            .padding(8)
            .frame(width: 60, height: 60)
            .imageScale(.large)
            .background(.red)
            .foregroundColor(.blue)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.5), radius: 10)
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
            
            Spacer()
            
            Toggle("", isOn: self.$viewModel.selectedPowerKey)
            

            
            HStack {
                // モード
                Button(action: {
                    self.viewModel.selectedMode += 1
                    
                    if (self.viewModel.selectedMode >= self.viewModel.mode.count) {
                        self.viewModel.selectedMode = 0
                    }
                }, label: {
                    VStack {
                        let value = self.viewModel.mode[self.viewModel.selectedMode]
                        CircleButtonView(name: value)
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
                        let value = self.viewModel.windStrength[self.viewModel.selectedWindStrength]
                        CircleButtonView(name: value)
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
                        let value = self.viewModel.direction[self.viewModel.selectedDirection]
                        CircleButtonView(name: value)

                    }
                })
            }
            
            Spacer(minLength: 30)
            
            ZStack {
                
                let minimum = AirConditionerRestriction.Min.rawValue
                let maximum = AirConditionerRestriction.Max.rawValue
                CircleSliderView(self.$viewModel.bindingTemperature,beginAngle: 0.1, endAngle: 0.9, minimumValue: minimum, maximumValue: maximum)
                Text("\(self.viewModel.temperature)°")
                    .font(.system(size: 60, weight: .medium, design: .default))

            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.sendSignal()
                }
            }, label: {
                Text("送信")
            })
            
            Spacer()
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
