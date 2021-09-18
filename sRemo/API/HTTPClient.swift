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
    public static func get(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async -> Result<Data, HTTPError> {
        guard var urlComponents = URLComponents(string: urlString) else {
            return .failure(.InvalidURL)
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
                return .failure(.UnknownError)
            }
                        
            if (200..<300).contains(httpResponse.statusCode) {
                return .success(data)
            } else {
                return .failure(.ErrorResponse)
            }
        } catch let error {
            return .failure(.ConnectionError(error))
        }
    }
    
    public static func post(url urlString: String, headers: [String: String] = [:], queries: [String: String] = [:]) async -> HTTPError {
        guard var urlComponents = URLComponents(string: urlString) else {
            return .InvalidURL
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
                return .UnknownError
            }
                        
            if (200..<300).contains(httpResponse.statusCode) {
                return .NoError
            } else {
                return .ErrorResponse
            }
        } catch let error {
            return .ConnectionError(error)
        }
    }
}
