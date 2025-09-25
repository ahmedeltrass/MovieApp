//
//  APIAuthorization.swift
//  POMacArch
//
//  Created by mohamed gamal on 07/12/2021.
//

import Foundation

public enum APIAuthorization {
    case none
    case bearerToken
    var authData: Any {
        switch self {
        case .none:
            return ["Accept": "application/json"]
        case .bearerToken:
            let token =  UserUtilites.loadToken() ?? ""
            print("token: \(token)")
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
