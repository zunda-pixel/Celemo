//
//  SettingsDetailViewModel.swift
//  sRemo
//
//  Created by zunda on 2021/09/18.
//

import Foundation

class SettingsDetailViewModel: ObservableObject {
    static func getDate(deviceModel: DeviceModel) async -> String{
        let result = await sRemoAPIClient.getDate(deviceModel: deviceModel)
        
        switch result {
            case .success(let data):
                do {
                    let dateTimeModel = try JSONDecoder().decode(DateTimeModel.self, from: data)
                    return "成功(\(dateTimeModel.date))"
                } catch {
                    return "失敗しました"
                }
            case .failure:
                return "失敗しました"
        }
    }
}

struct DateTimeModel: Decodable {
    var date: String
        
    public enum CodingKeys : String, CodingKey {
        case date = "t"
    }
}
