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
    case NoError
}

private enum HTTPMethod : String {
    case GET
    case POST
}

struct HTTPClient {
    public static func get(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async throws -> Data {
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
        
        request.httpMethod = HTTPMethod.GET.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        do {
            let (data, urlResponse) =  try await URLSession.shared.data(for: request)
                        
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw HTTPError.UnknownError
            }
                        
            if (200..<300).contains(httpResponse.statusCode) {
                return data
            } else {
                throw HTTPError.ErrorResponse
            }
        } catch let error {
            throw HTTPError.ConnectionError(error)
        }
    }
    
    public static func post(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async throws {
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
        
        request.httpMethod = HTTPMethod.POST.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let (_, urlResponse) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw HTTPError.UnknownError
            }
                        
            if (200..<300).contains(httpResponse.statusCode) {
                throw HTTPError.NoError
            } else {
                throw HTTPError.ErrorResponse
            }
        } catch let error {
            throw HTTPError.ConnectionError(error)
        }
    }
}
