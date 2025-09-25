//
//  Font.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation

enum Font: String {
    case bold = "FSAlbert-Bold"
    case medium = "FSAlbert-Medium"
    case light = "FSAlbert-Light"
    case regular = "FSAlbert-Regular"
    case extraBold = "FSAlbert-ExtraBold"
    case thin = "FSAlbert-Thin"
    case italic = "FSAlbert-Italic"
    var name: String {
        return self.rawValue
    }
}
