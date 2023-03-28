//
//  APIService.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation
import Alamofire

var urlBase = "https://api.github.com/search/repositories?sort=stars&order=desc&"

struct APIService: APIServiceProtocol {
    
    static let pageQueryPageKey = "page="
    static let pageQueryCreatedKey = "q=created:"
    
    func getRepositories(pageNum: String, created: String, completion: @escaping (Result<BaseResponse, APIError>) -> Void) {
        
        if !Connectivity.isConnectedToInternet() {
            completion(Result.failure(APIError.connection))
            return
        }
        
        let url = URL(string: urlBase + APIService.pageQueryPageKey + pageNum + "&" + APIService.pageQueryCreatedKey + created)!
        
        AF.request(url, method: .get).responseDecodable(of: BaseResponse.self) { response in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(BaseResponse.self, from: response.data!)
                completion(Result.success(res))
            } catch {
                completion(Result.failure(APIError.parsing(error as? DecodingError)))
            }
        }
    }
}


