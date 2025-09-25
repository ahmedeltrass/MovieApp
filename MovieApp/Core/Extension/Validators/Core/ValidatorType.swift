//
//  ValidatorType.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation

public enum ValidatorType: Equatable {
    case email
    case required(localizedFieldName: String)
    case name
    case age
    case password
    case confirmPassword(password: String)
    case confirmEmail(_ email: String)
    case mobileNumber
    //case characterCount(_ count: Int,_  stringName: String)
    case characterCount
    case ibanNumber
}
