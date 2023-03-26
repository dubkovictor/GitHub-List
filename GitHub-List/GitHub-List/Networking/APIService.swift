//
//  APIService.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation
import Alamofire

var urlBase = URL(string: "https://api.github.com/search/repositories?sort=stars&order=desc&page=1&q=created:2023-03-11..2023-03-12")

/*
 static let secureScheme = "https"
 static let githubHost = "api.github.com"
 static let searchReposPath = "/search/repositories"
 
 static let searchQueryParamKey = "q"
 static let querySeparator = " "
 
 static let sortQueryParamKey = "sort"
 static let sortSeparator = "="
 
 static let pageQueryParamKey = "page"
 
 // Search API query param keys
 static let stars = "stars"
 static let language = "language"
 
 static let queryParamKey = "key"
 static let queryParamValue = "value"
 */

struct APIService: APIServiceProtocol {
    
    func getRepositories(query: String, completion: @escaping (Result<BaseResponse, APIError>) -> Void) {
        
        AF.request(urlBase!, method: .get).responseDecodable(of: BaseResponse.self) { response in
            print(response.result)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(BaseResponse.self, from: response.data!)
                completion(Result.success(res))
            } catch {
                print(error)
                completion(Result.failure(APIError.parsing(error as? DecodingError)))
            }
        }
    }
}
