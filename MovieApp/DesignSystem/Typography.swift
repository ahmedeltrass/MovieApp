//
//  Typography.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import UIKit

extension DesignSystem {
    enum Typography {
        case title
        case discription
        case logo
        private var fontDiscriptor: CustomFontDiscriptor {
            switch self {
            case .title:
                return CustomFontDiscriptor(font: .bold, size: 20, style: .body)
            case .discription:
                return CustomFontDiscriptor(font: .medium, size: 18, style: .title2)
            case .logo:
                return CustomFontDiscriptor(font: .medium, size: 18, style: .body)
            }
        }
        var font: UIFont {
            guard let font = UIFont(name: fontDiscriptor.font.name, size: fontDiscriptor.size) else {
                return UIFont.preferredFont(forTextStyle: fontDiscriptor.style)
            }
            let fontMatrix = UIFontMetrics(forTextStyle: fontDiscriptor.style)
            return fontMatrix.scaledFont(for: font)
        }
    }
}
