//
//  SettingsView.swift
//  SettingsView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @State var isPresentedSettingDetailView: Bool = false
    
    var body: some View {
        List {
            Section (header:
                HStack {
                    Image(systemName: "person.fill")
                    Text("名前")
                    Spacer()
                }){
                TextField("名前", text: $settingsViewModel.settingsModel.registrationName)
            }
            
            Section(header:
                HStack {
                    Image(systemName: "person.fill")
                    Text("デバイス識別子")
                    Spacer()
                    Link(destination: URL(string: "https://sremo.biz/sremor_home")!, label: {
                        Image(systemName: "questionmark.circle")
                    })
                }){
                TextField("Device Identification", text: $settingsViewModel.settingsModel.registrationDeviceID)
            }
            
            Section (header:
                HStack {
                    Image(systemName: "person.fill")
                    Text("APIアクセストークン")
                    Spacer()
                    Link(destination: URL(string: "https://sremo.biz/sremor_home")!, label: {
                        Image(systemName: "questionmark.circle")
                    })
                }){
                TextField("API Key", text: $settingsViewModel.settingsModel.registrationApiKey)
            }
            
            Section {
                Button(action: {
                    self.settingsViewModel.registerDevice()
                }, label: {
                    Text("追加")
                })
            }
            .onAppear(perform: {
                settingsViewModel.loadDevices()
            })
            
            Section {
                ForEach(0..<settingsViewModel.settingsModel.savedDevices.count, id: \.self) { index in
                    let deviceModel = settingsViewModel.settingsModel.savedDevices[index]
                    
                    Button(action: {
                        self.isPresentedSettingDetailView.toggle()
                    }, label: {
                        HStack {
                            Text(deviceModel.name)
                            Spacer()
                        }
                    })
                    .sheet(isPresented: $isPresentedSettingDetailView) {
                        SettingsDetailView(deviceModel: deviceModel)
                    }
                }
                .onDelete(perform: self.settingsViewModel.removeDeviceModelAt)
            }
        }
        .listStyle(GroupedListStyle())
        .alert("エラー", isPresented: self.$settingsViewModel.happenedError, actions: {
            
        }, message: {
            HStack {
                Text(self.settingsViewModel.errorMessage)
            }
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
