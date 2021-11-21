//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by zunda on 2021/09/15.
//

import Foundation

public enum HTTPError : Error {
    case InvalidURL
    case ErrorResponse
    case ConnectionError(Error)
    case UnknownError
}

public enum HTTPMethod : String {
    case GET
    case POST
}

struct HTTPClient {
    private static func request(method: HTTPMethod, url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async throws -> (Data, URLResponse) {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw HTTPError.InvalidURL
        }
        
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in queries {
            let query = URLQueryItem(name: key, value: value)
            queryItems.append(query)
        }
        
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return try await URLSession.shared.data(for: request)
    }
    
    public static func get(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async throws -> Data {
        let (data, urlResponse) = try await HTTPClient.request(method: HTTPMethod.GET, url: urlString, headers: headers, queries: queries)
                    
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw HTTPError.UnknownError
        }
                    
        if (200..<300).contains(httpResponse.statusCode) {
            return data
        } else {
            throw HTTPError.ErrorResponse
        }
    }
    
    public static func post(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async throws {
        let (_, urlResponse) = try await HTTPClient.request(method: HTTPMethod.POST, url: urlString, headers: headers, queries: queries)
        
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw HTTPError.UnknownError
        }
                    
        if (200..<300).contains(httpResponse.statusCode) {
            return
        } else {
            throw HTTPError.ErrorResponse
        }
    }
}
