//
//  Error+Extension.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
public extension Error {
    var message: String {
        if let apiError = self as? APIManagerError {
            return apiError.message
        } else if let apiError = self as? APIRequestProviderError {
            return apiError.reason
        } else if let validationError = self as? ValidationError {
            return validationError.message
        } else {
            let error = self as NSError
            return error.domain
        }
    }

    var isNoInternet: Bool {
        message == "NoInternetError".localized
    }
}
extension NSError {
    static var apiFailure: NSError {
        NSError(domain: "APIFailureError".localized,
                code: 404,
                userInfo: nil)

    }

    static let cancelError = NSError(domain: "OperationCanceled".localized,
                                     code: 4000,
                                     userInfo: nil)

    static var noInternet: NSError {
        NSError(domain: "NoInternetError".localized,
                code: 5005,
                userInfo: nil)

    }

}
