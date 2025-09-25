//
//  RequiredFieldValidator.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
struct RequiredFieldValidator: Validatable {

    init() { }

    func validate(_ value: String) throws {
        guard !value.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw  ValidationError("Required Field".localized,
                                   type: .required(localizedFieldName: ""))
        }
    }

}
