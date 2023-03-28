//
//  APIError.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    case connection
    
    var localizedDescription: String {
        // user feedback
        switch self {
            case .badURL, .parsing, .unknown:
                return "Sorry, something went wrong."
            case .badResponse(_):
                return "Sorry, the connection to our server failed."
            case .url(let error):
                return error?.localizedDescription ?? "Something went wrong."
            case .connection:
                return "Lost Network connection"
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
            case .unknown: return "unknown error"
            case .badURL: return "invalid URL"
            case .url(let error):
                return error?.localizedDescription ?? "url session error"
            case .parsing(let error):
                return "parsing error \(error?.localizedDescription ?? "")"
            case .badResponse(statusCode: let statusCode):
                return "bad response with status code \(statusCode)"
            case .connection:
                return "Lost Network connection"
                
        }
    }
}
