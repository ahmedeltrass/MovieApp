//
//  MobileNumberValidator.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation

struct MobileNumberValidator: Validatable {

    func validate(_ value: String) throws {
        let number = value
        guard number.count != 0 else {
            throw  ValidationError("Required Field Error".localized,
                                   type: .mobileNumber)
        }
        if (value.starts(with: "5")) {
            if !(value.count >= 9) {
                throw ValidationError("invalid Mobile Number".localized,
                                      type: .mobileNumber)
            }
        }else if (value.starts(with: "05")){
            if !(value.count >= 10) {
                throw ValidationError("invalid Mobile Number".localized,
                                      type: .mobileNumber)
            }
        }else{
            throw ValidationError("Mobile Number must be start with 5 or 05 ".localized, type: .mobileNumber)
        }
    }
}


//struct IbanValid: Validatable {
//
//    func validate(_ value: String) throws {
//        let number = value
//        guard number.count != 0 else {
//            throw  ValidationError("Required Field".localized,
//                                   type: .ibanNumber)
//        }
//        if (value.starts(with: "SA")) {
//            if !(value.count == 25) {
//                throw ValidationError("invalid IBAN Number".localized,
//                                      type: .ibanNumber)
//            }
//        }else{
//            throw ValidationError("IBAN must be start with SA".localized, type: .ibanNumber)
//        }
//    }
//}
struct IbanValid: Validatable {
    func validate(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError("Required Field".localized, type: .ibanNumber)
        }
        
        // Ensure value starts with "SR" and has a space
        if !value.hasPrefix("SA ") {
            throw ValidationError("IBAN must start with SA followed by a space".localized, type: .ibanNumber)
        }
        
        // Extract numbers after "SR "
        let numbers = value.dropFirst(3) // Drop "SR " prefix
        
        // Ensure the remaining part consists of exactly 22 digits
        guard numbers.count == 22, numbers.allSatisfy(\.isNumber) else {
            throw ValidationError("IBAN must contain exactly 22 digits after SA and a space".localized, type: .ibanNumber)
        }
    }
    
}
