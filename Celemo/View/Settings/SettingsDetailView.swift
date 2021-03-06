//
//  SettingsDetailView.swift
//  Celemo
//
//  Created by zunda on 2021/09/17.
//

import SwiftUI

struct SettingsDetailView: View {
    @StateObject var viewModel: SettingsDetailViewModel = SettingsDetailViewModel()
    
    let deviceModel: DeviceModel
    
    var body: some View {
        List {
            Section(header: Text("デバイス情報")){
                HStack() {
                    Text("デバイス名")
                    Spacer()
                    Text(deviceModel.name)
                }
                HStack {
                    Text("デバイスID")
                    Spacer()
                    Text(deviceModel.deviceID)
                }
                HStack {
                    Text("APIキー")
                    Spacer()
                    Text(deviceModel.apiKey)
                }
                
                #if DEBUG
                    HStack {
                        Text("UUID")
                        Spacer()
                        Text(deviceModel.id)
                    }
                #endif
            }
                
            
            
            Button(action: {
                Task {
                    await viewModel.testAPI(self.deviceModel)
                }
            }, label: {
                HStack {
                    Text("接続テスト")
                    Spacer()
                    Text(viewModel.message)
                }
            })
        }
    }
}

struct SettingsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetailView(deviceModel: DeviceModel(name: "テスト名", deviceID: "テストデバイス名", apiKey: "テストAPIキー"))
    }
}
