//
//  TVView.swift
//  TVView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct TVView: View {
    let device: DeviceModel
    let appliancesNumber: Int
    
    @StateObject var viewModel: TVViewModel = TVViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await viewModel.sendSignal(Signal.TV.Power)
                }
            }, label: {
                Text("電源")
            })
            Button(action: {
                Task {
                    await viewModel.sendSignal(Signal.TV.SwitchInput)
                }
                
            }, label: {
                Text("入力切替")
            })
            Button(action: {
                Task {
                    await viewModel.sendSignal(Signal.TV.ScheduleTV)
                }
            }, label: {
                Text("番組表")
            })
            Button(action: {
                Task {
                    await viewModel.sendSignal(Signal.TV.Menu)
                }
            }, label: {
                Text("メニュー")
            })
            Button(action: {
                Task {
                    await viewModel.sendSignal(Signal.TV.Mute)
                }
            }, label: {
                Text("ミュート")
            })
            
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(1..<10) { index in
                    Button(
                        action: {
                            Task {
                                await viewModel.changeChannel(index)
                            }
                        },
                        label: {
                            Text(String(index))
                        }
                    )
                    .padding(35)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.device = self.device
            self.viewModel.appliancesNumber = self.appliancesNumber
        })

    }
}

struct TVView_Previews: PreviewProvider {
    static var previews: some View {
        TVView(device: DeviceModel(name: "test", deviceID: "test", apiKey: "test"), appliancesNumber: 0)
    }
}
