//
//  SwitchView.swift
//  SwitchView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct SwitchView: View {
    let device: DeviceModel
    let appliancesNumber: Int
    @StateObject var viewModel: SwitchViewModel = SwitchViewModel()

    var body: some View {
        VStack {
            Button(action: {
                viewModel.switchPower()
            }, label: {
                Text("電源")
            })
        }
        .onAppear(perform: {
            self.viewModel.device = self.device
            self.viewModel.appliancesNumber = self.appliancesNumber
        })
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView(device: DeviceModel(name: "test", deviceID: "test", apiKey: "test"), appliancesNumber: 0)
    }
}
