//
//  sRemoAPIClient.swift
//  Celemo
//
//  Created by zunda on 2021/09/18.
//

import Foundation

struct sRemoAPIClient {
    static let baseURL = "https://uapi1.sremo.net/user_api/"
    
    static func getHeaders(_ apiKey: String) -> [String: String] {
        return [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
        ]
    }
    
    static func getQueries(_ signal: String) -> [String: String] {
        return ["sig": signal]
    }
    
    static func sendSignal(signal: String, apiKey: String, deviceID: String) async throws {
        let url = "\(baseURL)/\(deviceID)/send_sig"
        try await HTTPClient.post(url: url, headers: self.getHeaders(apiKey), queries: self.getQueries(signal))
    }
    
    static func post(url: String, apiKey: String, queries: [String: String] = [:]) async throws {
        try await HTTPClient.post(url: url, headers: self.getHeaders(apiKey), queries: queries)
    }
    
    static func get(url: String, apiKey: String, queries: [String: String] = [:]) async throws -> Data {
        return try await HTTPClient.get(url: url, headers: self.getHeaders(apiKey), queries: queries)
    }
    
    static func getDate(_ deviceModel: DeviceModel) async throws -> Date {
        let url = "https://uapi1.sremo.net/user_api/\(deviceModel.deviceID)/get_time"
        
        let data = try await HTTPClient.get(url: url, headers: getHeaders(deviceModel.apiKey))
        let dateTimeModel = try JSONDecoder().decode(DateTimeModel.self, from: data)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale =  Locale.current

        guard let date = formatter.date(from: dateTimeModel.date) else {
            throw NSError(domain: "フォーマットが日付ではありません。", code: 0)
        }
        
        return date
    }
}
