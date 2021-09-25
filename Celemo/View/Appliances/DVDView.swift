//
//  DVDView.swift
//  DVDView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct DVDView: View {
    let device: DeviceModel
    let appliancesNumber: Int
    @StateObject var viewModel: DVDViewModel = DVDViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                self.viewModel.switchPower()
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

struct DVDView_Previews: PreviewProvider {
    static var previews: some View {
        DVDView(device: DeviceModel(name: "test", deviceID: "test", apiKey: "test"), appliancesNumber: 0)
    }
}
