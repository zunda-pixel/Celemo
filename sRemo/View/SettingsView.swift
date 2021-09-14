//
//  SettingsView.swift
//  SettingsView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    
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
                    Button(action: {
                        
                        
                    }, label: {
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
                    Button(action: {
                        
                    }, label: {
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
            
            Section {
                ForEach(settingsViewModel.settingsModel.savedDevices) { savedDevice in
                    Text(savedDevice.name)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

