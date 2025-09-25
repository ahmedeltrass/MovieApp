//
//  confirmEmailValidator.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation

struct ConfirmEmailValidator: Validatable {

    let email: String

    init(email: String) {
        self.email = email
    }

    func validate(_ value: String) throws {
        try value.validate(for: .email)

        guard email != value else {
            throw  ValidationError("different Email Invalid".localized,
                                   type: .confirmEmail(email))
        }
    }

}
