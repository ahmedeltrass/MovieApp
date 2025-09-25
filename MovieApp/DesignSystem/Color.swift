//
//  Coler.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import SwiftUI

extension DesignSystem {
    enum Colors: String {
        case main = "main"
        case splash = "splash"
        case background  = "background"
        case subTitle = "subTitle"
        case searchColor = "searchColor"
        case gray = "gray"
        case moreArrow = "moreArrow"
        case profile = "profile"
        case subBackground = "subBackground"
        case mainColorWithOpacity = "mainColorWithOpacity"
        case itemColor = "itemColor"
        case deleteColorBackground = "deleteColorBackground"
        case titelClolr = "titelClolr"
        case deleteColor = "deleteColor"
        case RateBackGround = "RateBackGround"
        case ChatSenderColor = "ChatSenderColor"
        case unreadNotifiction = "unreadNotifiction"
        case lightGray = "LightGray"
        var color: Color {
            switch self {
            case .main, .splash , .background, .subTitle, .searchColor,.gray,.moreArrow, .profile, .subBackground,.mainColorWithOpacity,.itemColor,.deleteColorBackground,.titelClolr,.deleteColor,.RateBackGround,.ChatSenderColor,.unreadNotifiction,.lightGray:
                return Color(self.rawValue)
            }
        }
    }
}
