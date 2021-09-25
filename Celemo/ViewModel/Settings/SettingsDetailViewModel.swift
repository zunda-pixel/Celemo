//
//  SettingsDetailViewModel.swift
//  Celemo
//
//  Created by zunda on 2021/09/18.
//

import Foundation

actor SettingsDetailViewModel: ObservableObject {
    @MainActor @Published var message: String
    
    @MainActor init() {
        message = ""
    }
    
    @MainActor func testAPI(_ deviceModel: DeviceModel) async {
        message = "テスト中です"
        do {
            let date = try await sRemoAPIClient.getDate(deviceModel)
            
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("yyyyMMddHHmmss")
            let dateString = formatter.string(from: date)
            
            message = "成功(\(dateString))"
        } catch {
            message = "失敗"
        }
        
    }
}

struct DateTimeModel: Decodable {
    var date: String
        
    public enum CodingKeys : String, CodingKey {
        case date = "t"
    }
}
