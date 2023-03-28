//
//  Connectivity.swift
//  GitHub-List
//
//  Created by Victor on 28.03.2023.
//

import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
