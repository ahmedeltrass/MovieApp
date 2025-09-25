//
//  NSObject+Extension.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
import UIKit
extension NSObject {
    /// value that represent a className as string value
    static var className: String {
        return String(describing: self)
    }
    var className: String {
        return String(describing: self)
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        // let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1.0, height: 2.0))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
