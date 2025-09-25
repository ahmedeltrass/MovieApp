//
//  confirmPasswordValidator.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
struct ConfirmPasswordValidator: Validatable {

    let password: String
    init(password: String) {
        self.password = password
    }
    func validate(_ value: String) throws {
        guard value.count != 0 else {
            throw  ValidationError("Required Field".localized,
                                   type: .confirmPassword(password: password))
        }
        guard password == value  else {
            throw  ValidationError("passwords do not match".localized,
                                   type: .confirmPassword(password: password))
        }
    }

}
