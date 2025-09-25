//
//  NameValidator.swift
//  Hagazt
//
//  Created by POMAC on 23/01/2024.
//

import Foundation
struct NameValidator : Validatable {
    func validate(_ value: String) throws {
        if value.isEmpty {
            throw ValidationError("Required Field".localized,
                                  type: .name)
        }
        // Customize the validation criteria for names as needed
     //   let nameRegEx =  "^[A-Za-z\\s\\p{Arabic}]+$"
      //  let nameRegEx =   #"^([a-zA-Z]+|[ء-ي]+)$"#
        let nameRegEx = "^[a-zA-Z]+(?: [a-zA-Z]+)*|[ء-ي]+(?: [ء-ي]+)*$"
        let trimmedname = value.trimmingCharacters(in: .whitespaces)
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let result = nameTest.evaluate(with: trimmedname)
        if !result {
            throw ValidationError("Please enter valid user name that doesn't contain numbers or special characters".localized,
                                  type: .name)
        }
    }
}
