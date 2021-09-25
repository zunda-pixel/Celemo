//
//  LightView.swift
//  LightView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct LightView: View {
    let device: DeviceModel
    let appliancesNumber: Int
    @StateObject var viewModel: LightViewModel = LightViewModel()
    
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

struct LightView_Previews: PreviewProvider {
    static var previews: some View {
        LightView(device: DeviceModel(name: "test", deviceID: "test", apiKey: "test"), appliancesNumber: 0)
    }
}
