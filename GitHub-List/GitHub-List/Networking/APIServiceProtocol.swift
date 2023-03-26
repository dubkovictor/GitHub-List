//
//  APIServiceProtocol.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

protocol APIServiceProtocol {
    
    func getRepositories(query: String, completion: @escaping (Result<BaseResponse, APIError>) -> Void)
}
