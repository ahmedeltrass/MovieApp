//
//  PasswordValidator.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation

struct PasswordValidator: Validatable {

    func validate(_ value: String) throws {
        if value.isEmpty {
            throw ValidationError("Required Field".localized,
                                  type: .password)
        }
       // ^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%\\-*?&])[A-Za-z\\d\\-$@$!%*?&.]{8,}
       // let passwordRegex = "^(?=.*\\d)[A-Za-z\\d\\-$@$!%*?&.]{8,}"
       // let passwordRegex =  "^(?=.*[a-zA-Z])(?=.*\\d)[A-Za-z\\d$@$!%*?&.]{8,}$"
      //  let passwordRegex =   "^(?=.*\\d).{8,}$"
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: value)
        if !result {
            throw ValidationError("Password must be 8 chars at least - with at least one alphabetical.".localized,
                                  type: .password)
        }
    }
}
