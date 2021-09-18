//
//  sRemoAPIClient.swift
//  sRemo
//
//  Created by zunda on 2021/09/18.
//

import Foundation

struct sRemoAPIClient {
    static func getHeaders(_ apiKey: String) -> [String: String] {
        return [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
        ]
    }
    
    static func get(url: String, apiKey: String, queries: [String: String] = [:]) async -> Result<Data, HTTPError> {
        return await HTTPClient.get(url: url, headers: self.getHeaders(apiKey), queries: queries)
    }
    
    
    static func getDate(deviceModel: DeviceModel) async -> Result<Data, HTTPError> {
        let url = "https://uapi1.sremo.net/user_api/\(deviceModel.deviceID)/get_time"
        
        return await HTTPClient.get(url: url, headers: getHeaders(deviceModel.apiKey))
    }
}
