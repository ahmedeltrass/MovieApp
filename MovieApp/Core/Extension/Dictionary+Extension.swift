//
//  Dictionary+Extension.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any? {
    func withNestedNilValuesRemoved() -> [String: Any] {
        var filtered = [String: Any]()
        for (key, value) in self {
            if value != nil && !(value is NSNull) {
                if let value  = value as? [String: Any?] {
                    let value  = value.withNestedNilValuesRemoved()
                    if value.count != 0 {
                        filtered[key] = value
                    }
                } else {
                    filtered[key] = value
                }
            }
        }
        return filtered
    }
}
