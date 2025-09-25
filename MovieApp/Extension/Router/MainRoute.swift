//
//  MainRoute.swift
//  WHBusiness
//
//  Created by Morsy Mohamed Elsokary on 14/08/2023.
//

import Foundation
import UIKit
import SwiftUI

enum MainRoute: Equatable, Identifiable {
    static func == (lhs: MainRoute, rhs: MainRoute) -> Bool {
       return lhs.id == rhs.id
    }
    case splachScreen
    case homeScreen
    case movieDetailsScreen(id:Int)
    var id: String {
        switch self {
        case  .splachScreen:
            return "splachScreen"
        case  .homeScreen:
            return "splachScreen"
        case  .movieDetailsScreen:
            return "MovieDetailsScreen"
        }
    }
}
