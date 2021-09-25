//
//  TVViewModel.swift
//  TVViewModel
//
//  Created by zunda on 2021/09/13.
//

import Foundation

class TVViewModel: ObservableObject {
    var device: DeviceModel? = nil
    var appliancesNumber: Int? = nil
    
    func sendSignal(_ signal: Signal.TV) async {
        guard let appliancesNumber = appliancesNumber,
              let apiKey = device?.apiKey,
              let deviceID = device?.deviceID else { return }

        let signal = "\(appliancesNumber)-t-\(signal.rawValue)"

        do {
            try await sRemoAPIClient.sendSignal(signal: signal, apiKey: apiKey, deviceID: deviceID)
        } catch {
            
        }
    }
    
    func changeChannel(_ channel: Int) async {
        var selectedChannel: Signal.TV = .Ch1
        
        if channel == 1 {
            selectedChannel = .Ch1
        }
        if channel == 2 {
            selectedChannel = .Ch2
        }
        if channel == 3 {
            selectedChannel = .Ch3
        }
        if channel == 4 {
            selectedChannel = .Ch4
        }
        if channel == 5 {
            selectedChannel = .Ch5
        }
        if channel == 6 {
            selectedChannel = .Ch6
        }
        if channel == 7 {
            selectedChannel = .Ch7
        }
        if channel == 8 {
            selectedChannel = .Ch8
        }
        if channel == 9 {
            selectedChannel = .Ch9
        }
        if channel == 10 {
            selectedChannel = .Ch10
        }
        if channel == 11 {
            selectedChannel = .Ch11
        }
        if channel == 12 {
            selectedChannel = .Ch12
        }
        
        await sendSignal(selectedChannel)
    }
}

